<script setup>
import { ref } from 'vue'
import { Slot, Venue } from '@/domain/domain'
import { range, pad2, toGridRow } from '@/domain/grid'
import jsonSlots from '@/domain/slots.json'
import jsonVenues from '@/domain/venues.json'

const venues = jsonVenues.map(Venue.fromJson)
const ranksByVenueName = venues.reduce((agg, venue) => ({...agg, [venue.name]: venue.rank}), {})

const slots = jsonSlots.map(jsonSlot => Slot.fromJson(jsonSlot, ranksByVenueName))

// creates the CSS variables for the time table and the tracks
const startHour = Math.floor(Math.min(
    ...slots.map(slot => slot.decimalStartHour())
))
const endHour = Math.ceil(Math.max(
    ...slots.map(slot => slot.decimalEndHour())
))
console.log({slots, startHour, endHour})
const hours = range(endHour - startHour, startHour)
const minutes = range(12, 0, 5)
const rowHeightMode = 'auto'
const timeGridRows = [].concat(
    '[tracks] auto',
    ...hours.map(hour => minutes.map(minute => `[${toGridRow(hour, minute)}] ${rowHeightMode}`))
)
timeGridRows.push(`[${toGridRow(endHour, minutes[0])}] auto`)

const timeGridRowsCSS = ref(timeGridRows.reduce((css, timeGridRow) => `${css} ${timeGridRow}`))
const timeGridLabels = ref(
    [
        ...range((endHour - startHour) * 2, startHour, 0.5),
        endHour
    ].map(hour => hour % 1 == 0 ? {hour: hour, paddedHour: pad2(hour), paddedMinute: '00'}: {hour: Math.trunc(hour), paddedHour: pad2(Math.trunc(hour)), paddedMinute: '30'})
)

const tracksNumber = venues.length
const tracksGridColumns = [
    '[times] 4em',
    '[track-1-start] 1fr',
    ...range(tracksNumber - 1, 1).map(trackIndex => `[track-${trackIndex}-end track-${trackIndex + 1}-start] 1fr`),
    `[track-${tracksNumber}-end] 1fr`
]
const timeGridVenues = ref(venues)
const timeGridColumnsCSS = ref(tracksGridColumns.reduce((css, tracksGridColumn) => `${css} ${tracksGridColumn}`))
const timeGridSlots = ref(slots)
</script>

<template>
    <h2 id="schedule-heading">BreizhCamp members agenda</h2>

    <div class="schedule">
        <span v-for="timeGridVenue in timeGridVenues" :key="timeGridVenue.id" class="track-slot" aria-hidden="true" :style="`grid-column: track-${timeGridVenue.rank}; grid-row: tracks;`">{{timeGridVenue.name}}</span>

        <h2 v-for="timeGridLabel in timeGridLabels" class="time-slot" :style="`grid-row: time-${timeGridLabel.paddedHour}${timeGridLabel.paddedMinute};`">{{timeGridLabel.hour}}:{{timeGridLabel.paddedMinute}}</h2>
       
        <div v-for="timeGridSlot in timeGridSlots" :class="`session track-${timeGridSlot.rank}`" :style="`grid-column: track-${timeGridSlot.rank}; grid-row: ${timeGridSlot.gridRowStart} / ${timeGridSlot.gridRowEnd};`">
            <h3 class="session-title"><a href="#">{{ timeGridSlot.name }}</a></h3>
            <span class="session-time">{{ timeGridSlot.startHour }}:{{ timeGridSlot.startMinute }} - {{ timeGridSlot.endHour }}:{{ timeGridSlot.endMinute }}</span>
            <span class="session-track">({{ timeGridSlot.venue }})</span>
            <span class="session-track">{{ timeGridSlot.members.length }} / {{ timeGridSlot.membersNeededMin }}</span>
        </div>
    </div>
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
