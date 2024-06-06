<script setup>
import { ref } from 'vue'

// creates the CSS variables for the time table and the tracks
function range(size, startAt = 0, step = 1) {
    return [...Array(size).keys()].map(index => startAt + (index * step) );
}
function pad2(value) {
    return `${value}`.padStart(2, '0')
}
const startHour = 8
const endHour = 12
const hours = range(endHour - startHour, startHour).map(pad2)
const minutes = range(12, 0, 5).map(pad2)
const rowHeightMode = 'auto'
const timeGridRows = [].concat(
    '[tracks] auto',
    ...hours.map(hour => minutes.map(minute => `[time-${hour}${minute}] ${rowHeightMode}`))
)
timeGridRows.push(`[time-${pad2(endHour)}${minutes[0]}] auto`)

const timeGridRowsCSS = ref(timeGridRows.reduce((css, timeGridRow) => `${css} ${timeGridRow}`))
const timeGridLabels = ref(
    [
        ...range((endHour - startHour) * 2, startHour, 0.5),
        endHour
    ].map(hour => hour % 1 == 0 ? {hour: hour, paddedHour: pad2(hour), paddedMinute: '00'}: {hour: Math.trunc(hour), paddedHour: pad2(Math.trunc(hour)), paddedMinute: '30'})
)
class Venue {
  constructor(rank, name) {
      this.rank = rank
      this.name = name
  }
}
const venues = [
    new Venue(1, 'Amphi 1'),
    new Venue(2, 'Amphi 2'),
    new Venue(3, 'Amphi 3'),
    new Venue(4, 'Amphi 4'),
]
const ranksByVenueName = venues.reduce((agg, venue) => ({...agg, [venue.name]: venue.rank}), {})
const tracksNumber = venues.length
const tracksGridColumns = [
    '[times] 4em',
    '[track-1-start] 1fr',
    ...range(tracksNumber - 1, 1).map(trackIndex => `[track-${trackIndex}-end track-${trackIndex + 1}-start] 1fr`),
    `[track-${tracksNumber}-end] 1fr`
]
const tracks = ref(venues)
const timeGridColumnsCSS = ref(tracksGridColumns.reduce((css, tracksGridColumn) => `${css} ${tracksGridColumn}`))
</script>

<template>
    <h2 id="schedule-heading">BreizhCamp members agenda</h2>
    <div class="schedule">

        <span v-for="track in tracks" :key="track.id" class="track-slot" aria-hidden="true" :style="`grid-column: track-${track.rank}; grid-row: tracks;`">{{track.name}}</span>

        <h2 v-for="timeGridLabel in timeGridLabels" class="time-slot" :style="`grid-row: time-${timeGridLabel.paddedHour}${timeGridLabel.paddedMinute};`">{{timeGridLabel.hour}}:{{timeGridLabel.paddedMinute}}</h2>
       
        <div class="session session-1 track-1" style="grid-column: track-1; grid-row: time-0800 / time-0900;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">8:00 - 9:00</span>
            <span class="session-track">Track: 1</span>
            <span class="session-presenter">Presenter</span>
        </div>

        <div class="session session-2 track-2" style="grid-column: track-2; grid-row: time-0800 / time-0830;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">8:00 - 8:30</span>
            <span class="session-track">Track: 2</span>
            <span class="session-presenter">Presenter</span>
        </div>  

        <div class="session session-3 track-3" style="grid-column: track-3; grid-row: time-0800 / time-0830;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">8:00 - 8:30</span>
            <span class="session-track">Track: 3</span>
            <span class="session-presenter">Presenter</span>
        </div>

        <div class="session session-4 track-4" style="grid-column: track-4; grid-row: time-0800 / time-1000;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">8:00 - 10:00</span>
            <span class="session-track">Track: 2</span>
            <span class="session-presenter">Presenter</span>
        </div>

        
        <div class="session session-5 track-3" style="grid-column: track-3; grid-row: time-0830 / time-1000;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">8:30 - 10:00</span>
            <span class="session-track">Track: 1</span>
            <span class="session-presenter">Presenter</span>
        </div>
        
        
        <div class="session session-6 track-1" style="grid-column: track-1-start / track-2-end; grid-row: time-0900 / time-1000;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">9:00 - 10:00</span>
            <span class="session-track">Track: 1 & 2</span>
            <span class="session-presenter">Presenter</span>
        </div>
        
        
        <div class="session session-7 track-all" style="grid-column: track-1-start / track-4-end; grid-row: time-1000 / time-1030;">
            <h3 class="session-title">Take a break!</h3>
        </div>

        
        <div class="session session-8 track-1" style="grid-column: track-1; grid-row: time-1030 / time-1130;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">10:30 - 11:30</span>
            <span class="session-track">Track: 1</span>
            <span class="session-presenter">Presenter</span>
        </div>

        <div class="session session-9 track-2" style="grid-column: track-2-start / track-3-end; grid-row: time-1030 / time-1100;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">10:30 - 11:00</span>
            <span class="session-track">Track: 2 & 3</span>
            <span class="session-presenter">Presenter</span>
        </div>
        
        <div class="session session-10 track-4" style="grid-column: track-4; grid-row: time-1030 / time-1100;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">10:30 - 11:00</span>
            <span class="session-track">Track: 4</span>
            <span class="session-presenter">Presenter</span>
        </div>
        
        <div class="session session-11 track-2" style="grid-column: track-2; grid-row: time-1100 / time-1200;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">11:00 - 12:00</span>
            <span class="session-track">Track: 2</span>
            <span class="session-presenter">Presenter</span>
        </div>
        
        <div class="session session-11 track-3" style="grid-column: track-3; grid-row: time-1100 / time-1200;">
            <h3 class="session-title"><a href="#">Talk Title</a></h3>
            <span class="session-time">11:00 - 12:00</span>
            <span class="session-track">Track: 3</span>
            <span class="session-presenter">Presenter</span>
        </div>
    </div>
</template>

<style scoped>
@import "../assets/agenda.scss";

@media screen and (min-width:700px) {
    .schedule {
      display: grid;
      grid-gap: 1em;
      grid-auto-rows: 0;
      grid-template-rows: v-bind(timeGridRowsCSS);
      grid-template-columns: v-bind(timeGridColumnsCSS);
    }
}
</style>
