<script setup>
import { Slot } from '@/domain/domain'

const props = defineProps({
    slot: Slot,
})
</script>

<template>
    <div class="session"
      :style="`grid-column: track-${slot.rank}; grid-row: ${slot.gridRowStart} / ${slot.gridRowEnd}; background-color: #${slot.bgColorHex}`"
     >
        <h3 class="session-title"><a href="#">{{ slot.name }}</a></h3>
        <span class="session-time">{{ slot.startHour }}:{{ slot.startMinute }} - {{ slot.endHour }}:{{ slot.endMinute }}</span>
        <span class="session-track">({{ slot.venue }})</span>
        <span class="session-members-needed">{{ slot.members.length }} / {{ slot.membersNeededMin }}</span>
    </div>
</template>

<style scoped>
@import "../assets/slot-item.scss";
</style>
