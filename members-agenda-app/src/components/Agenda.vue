<script setup>
import { ref } from 'vue'
import { Slot, Venue } from '@/domain/domain'
import { range, pad2, toGridRow } from '@/domain/grid'
import jsonSlots from '@/domain/slots.json'
import jsonVenues from '@/domain/venues.json'

import SlotItem from '@/components/SlotItem.vue'
import AddMemberModal from '@/components/AddMemberModal.vue'

const loaded = ref(false)
const timeGridSlots = ref([])

const timeGridVenues = ref(null)
const timeGridLabels = ref([])
const timeGridRowsCSS = ref('')
const timeGridColumnsCSS = ref('')

function initWithSlots(slots) {
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

function loadSlots(venues) {
    const ranksByVenueName = venues.reduce((agg, venue) => ({...agg, [venue.name]: venue.rank}), {})
    fetch('/api/slots/in-period?start=2024-06-28T00:00:00&end=2024-06-28T23:59:59').then(
        slotsResponse => slotsResponse.json().then(
            jsonSlots => {
                const slots = jsonSlots.map(jsonSlot => Slot.fromApiJson(jsonSlot, venues, ranksByVenueName))
                timeGridSlots.value = slots
                initWithSlots(slots)
                loaded.value = true
            })
    )
}
fetch('/api/venues').then(
    venuesResponse => venuesResponse.json().then(
        venuesJson => {
            const venues = venuesJson.map(Venue.fromApiJson)

            const tracksNumber = venues.length
            const tracksGridColumns = [
                '[times] 4em',
                '[track-1-start] 1fr',
                ...range(tracksNumber - 1, 1).map(trackIndex => `[track-${trackIndex}-end track-${trackIndex + 1}-start] 1fr`),
                `[track-${tracksNumber}-end] 1fr`
            ]
            timeGridColumnsCSS.value = tracksGridColumns.reduce((css, tracksGridColumn) => `${css} ${tracksGridColumn}`)

            timeGridVenues.value = venues
            // console.log({venues})
            loadSlots(venues)
        }
    )
)

const isModalOpened = ref(false);

const openModal = () => {
  isModalOpened.value = true
}
const closeModal = () => {
  isModalOpened.value = false
}

const submitHandler = ()=> {
    console.log("modal submission")
}
</script>

<template>
    <h2 id="schedule-heading">BreizhCamp members agenda</h2>

    <div class="schedule" v-if="loaded">
        <span v-for="timeGridVenue in timeGridVenues" :key="timeGridVenue.id" class="track-slot" aria-hidden="true" :style="`grid-column: track-${timeGridVenue.rank}; grid-row: tracks;`">{{timeGridVenue.name}}</span>

        <h2 v-for="timeGridLabel in timeGridLabels" class="time-slot" :style="`grid-row: time-${timeGridLabel.paddedHour}${timeGridLabel.paddedMinute};`">{{timeGridLabel.hour}}:{{timeGridLabel.paddedMinute}}</h2>
       
        <SlotItem v-for="timeGridSlot in timeGridSlots" :key="timeGridSlot.id" :slot="timeGridSlot" />
    </div>

    <div>
        <button @click="openModal">Open modal</button>
    </div>

    <AddMemberModal :isOpen="isModalOpened" @modal-close="closeModal" @submit="submitHandler" name="first-modal">
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
