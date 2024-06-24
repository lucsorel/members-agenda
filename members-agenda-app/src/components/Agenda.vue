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

const assignmentsSlot = ref(null)
const openSlotAssignmentModal = ref(false)
const assignmentLastError = ref(null)

const openModal = (slot) => {
    assignmentsSlot.value = slot
    assignmentLastError.value = null
    openSlotAssignmentModal.value = true
}
const closeModal = () => {
    assignmentsSlot.value = null
    assignmentLastError.value = null
    openSlotAssignmentModal.value = false
}

async function addMemberToSlot(slot, memberToAdd) {
    assignmentLastError.value = null
    const addMemberResponse = await fetch(
        `/api/slots/${slot.id}/add-member?member_id=${memberToAdd.id}`,
        {method: 'POST'}
    ).then(response => response.json())
    if (addMemberResponse == 1) {
        slot.members.push(memberToAdd)
    } else {
        let errorMessage = `${memberToAdd.fullname} n'est pas disponible, elle ou il intervient déjà dans`
        if (addMemberResponse.member_slots.length > 0) {
            const memberSlot = addMemberResponse.member_slots[0]
            errorMessage += ` un autre slot (${venues.find(venue => venue.id === memberSlot.venue_id).name} : "${memberSlot.title}").`
        } else {
            const speakerEvent = addMemberResponse.speaker_events[0]
            errorMessage += ` une conférence (${venues.find(venue => venue.id === speakerEvent.venue_id).name} : "${speakerEvent.title}").`
        }
        assignmentLastError.value = errorMessage
    }
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
    <h2 id="schedule-heading">BreizhCamp members agenda - jeudi 27 juin 2024</h2>
    
    <div class="schedule" v-if="loaded">
        <span v-for="timeGridVenue in timeGridVenues" :key="timeGridVenue.id" class="track-slot" aria-hidden="true" :style="`background-color: #${timeGridVenue.bgColorHex}; grid-column: track-${timeGridVenue.rank}; grid-row: tracks;`">{{timeGridVenue.name}}</span>
        
        <h2 v-for="timeGridLabel in timeGridLabels" class="time-slot" :style="`grid-row: time-${timeGridLabel.paddedHour}${timeGridLabel.paddedMinute};`">{{timeGridLabel.hour}}:{{timeGridLabel.paddedMinute}}</h2>
       
        <SlotItem v-for="timeGridSlot in timeGridSlots" :key="timeGridSlot.id" :slot="timeGridSlot"
            @add-member="openModal"
            @remove-member="removeMemberFromSlot"
        />
    </div>

    <AddMemberModal class="assign-member" :isOpen="openSlotAssignmentModal" @modal-close="closeModal" name="add-members" :slot="assignmentsSlot" :members="members">
        <template #header>Affecter / retirer des membres</template>
        <template #content>
            <div>
                <div v-if="assignmentsSlot == null">Pas de slot défini à staffer.</div>
                <div v-if="assignmentsSlot">
                    <div>
                        <strong>
                            {{ assignmentsSlot.title }}
                        </strong>
                        - 
                        <span>
                            {{ assignmentsSlot.venue }}
                        </span>
                        - 
                        <span>
                            {{ assignmentsSlot.startHour }}:{{ assignmentsSlot.startMinute }} - {{ assignmentsSlot.endHour }}:{{ assignmentsSlot.endMinute }}
                        </span>
                    </div>
                    <div>
                        <span>
                            Besoins : {{ assignmentsSlot.members.length }} membre·s / {{ assignmentsSlot.membersNeededMin }} requis
                        </span>
                    </div>
                    <div class="members">
                        <div v-if="assignmentLastError" class="assignment-error">{{ assignmentLastError }}</div>
                        <div v-for="member in members" :key="member.id" class="member">
                            <span v-if="! assignmentsSlot.members.includes(member)" class="action add" @click="addMemberToSlot(assignmentsSlot, member)">➕</span>
                            <span v-if="assignmentsSlot.members.includes(member)" class="action remove" @click="removeMemberFromSlot(assignmentsSlot, member)">❌</span>
                            <span>&nbsp;{{ member.fullname }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </template>
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
.assign-member{
    .members {
        margin-top: 10px;
        .member {
            display: inline-block;
            width: 49%;
            text-align: left;
        }
    }
}
.action {
    cursor: pointer;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.5);
    border: 1px solid white;
    padding: 0 0.5em;
    margin: 0.2em 0;
    display: inline-block;
    
    &:hover {
        background: rgba(255, 255, 255, 0.75);
    }
}
.action.remove {
    &:hover {
        border: 1px solid red;
    }
}
.action.add {
    &:hover {
        border: 1px solid rgb(58, 143, 58);
    }
}
.assignment-error {
    border-radius: 5px;
    color: red;
    background: rgba(255, 255, 255, 0.8);
    border: 1px solid white;
    padding: 0 0.5em;
    margin: 0.2em 0;
    display: inline-block;
    text-align: left;
}
</style>
