<script setup>
import { ref } from 'vue'
import { Assignment, Member, Slot, Venue } from '@/domain/domain'
import { range, pad2, toGridRow } from '@/domain/grid'

import SlotItem from '@/components/SlotItem.vue'
import AddMemberModal from '@/components/AddMemberModal.vue'

const loaded = ref(false)

const timeGridLabels = ref([])
const timeGridRowsCSS = ref('')
const timeGridColumnsCSS = ref('')


async function fetchMembers() {
    const membersJson = await fetch('/api/people/members').then(membersResponse => membersResponse.json())
    return membersJson.map(Member.fromApiJson)
}
async function fetchAssignments(startDatetime, endDatetime) {
    const assignmentsJson = await fetch(`/api/assignments/in-period?start=${startDatetime}&end=${endDatetime}`).then(membersResponse => membersResponse.json())
    return assignmentsJson.map(Assignment.fromApiJson)
}

function initGridWithSlots(slots) {
    // creates the CSS variables for the time table and the tracks
    const startHour = Math.floor(Math.min(
        ...slots.map(slot => slot.decimalStartHour())
    ))
    const endHour = Math.ceil(Math.max(
        ...slots.map(slot => slot.decimalEndHour())
    ))
    // console.log({slots, startHour, endHour})
    const hours = range(endHour - startHour, startHour)
    const minutes = range(12, 0, 5)
    const rowHeightMode = 'auto'
    const timeGridRows = [].concat(
        '[tracks] auto',
        ...hours.map(hour => minutes.map(minute => `[${toGridRow(hour, minute)}] ${rowHeightMode}`))
    )
    timeGridRows.push(`[${toGridRow(endHour, minutes[0])}] auto`)

    timeGridRowsCSS.value = timeGridRows.reduce((css, timeGridRow) => `${css} ${timeGridRow}`)
    timeGridLabels.value = [
        ...range((endHour - startHour) * 2, startHour, 0.5),
        endHour
    ].map(hour => hour % 1 == 0 ? {hour: hour, paddedHour: pad2(hour), paddedMinute: '00'}: {hour: Math.trunc(hour), paddedHour: pad2(Math.trunc(hour)), paddedMinute: '30'})
}

async function loadSlots(venues, startDatetime, endDatetime, members, assignments) {
    const ranksByVenueName = venues.reduce((agg, venue) => ({...agg, [venue.name]: venue.rank}), {})
    
    const jsonSlots = await fetch(`/api/slots/in-period?start=${startDatetime}&end=${endDatetime}`).then(
        slotsResponse => slotsResponse.json()
    )
    const membersById = members.reduce((agg, member) => ({...agg, [member.id]: member}), {})

    return jsonSlots.map(jsonSlot => Slot.fromApiJson(jsonSlot, venues, ranksByVenueName, membersById, assignments))
}

async function fetchVenues() {
    const venuesJson = await fetch('/api/venues').then(venuesResponse => venuesResponse.json())
    const venues = venuesJson.map(Venue.fromApiJson)
    
    const tracksNumber = venues.length
    const tracksGridColumns = [
        '[times] 4em',
        '[track-1-start] 1fr',
        ...range(tracksNumber - 1, 1).map(trackIndex => `[track-${trackIndex}-end track-${trackIndex + 1}-start] 1fr`),
        `[track-${tracksNumber}-end] 1fr`
    ]
    timeGridColumnsCSS.value = tracksGridColumns.reduce((css, tracksGridColumn) => `${css} ${tracksGridColumn}`)
    return venues
}

const startDatetime = '2024-06-27T00:00:00'
const endDatetime = '2024-06-27T23:59:59'

const venues = await fetchVenues()
const timeGridVenues = ref(venues)
const members = ref(await fetchMembers())
const assignments = await fetchAssignments(startDatetime, endDatetime)
const slots = await loadSlots(venues, startDatetime, endDatetime, members.value, assignments)
const timeGridSlots = ref(slots)
initGridWithSlots(slots)

loaded.value = true

const isModalOpened = ref(false)

const openModal = () => {
    isModalOpened.value = true
}
const closeModal = () => {
    isModalOpened.value = false
}

const submitHandler = () => {
    console.log("modal submission")
}

function addMemberToSlot(slot) {
    console.log(slot)
}

async function removeMemberFromSlot(slot, memberToRemove) {
    const membersRemovedNb = await fetch(
        `/api/assignments?slot_id=${slot.id}&member_id=${memberToRemove.id}`,
        {method: 'DELETE'}
    ).then(removeResponse => removeResponse.json())
    if (membersRemovedNb > 0) {
        slot.members = slot.members.filter(member => member.id != memberToRemove.id)
    }
}
</script>

<template>
    <h2 id="schedule-heading">BreizhCamp members agenda</h2>
    
    <div class="schedule" v-if="loaded">
        <span v-for="timeGridVenue in timeGridVenues" :key="timeGridVenue.id" class="track-slot" aria-hidden="true" :style="`grid-column: track-${timeGridVenue.rank}; grid-row: tracks;`">{{timeGridVenue.name}}</span>
        
        <h2 v-for="timeGridLabel in timeGridLabels" class="time-slot" :style="`grid-row: time-${timeGridLabel.paddedHour}${timeGridLabel.paddedMinute};`">{{timeGridLabel.hour}}:{{timeGridLabel.paddedMinute}}</h2>
       
        <SlotItem v-for="timeGridSlot in timeGridSlots" :key="timeGridSlot.id" :slot="timeGridSlot"
            @add-member="addMemberToSlot"
            @remove-member="removeMemberFromSlot"
        />
    </div>
    
    <div>
        <button @click="openModal">Open modal</button>
    </div>
    
    <AddMemberModal :isOpen="isModalOpened" @modal-close="closeModal" @submit="submitHandler" name="first-modal" :members="members">
        <template #header>Manage team members on a slot</template>
        <template #content>Display available team members</template>
    </AddMemberModal>
</template>

<style scoped>
@import "../assets/agenda.scss";

@media screen and (min-width:700px) {
    .schedule {
        display: grid;
        grid-gap: 0.5em;
        grid-auto-rows: 0;
        grid-template-rows: v-bind(timeGridRowsCSS);
        grid-template-columns: v-bind(timeGridColumnsCSS);
    }
}
</style>
