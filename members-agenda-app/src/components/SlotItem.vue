<script setup>
import { Slot } from '@/domain/domain'

const props = defineProps({
    slot: Slot,
})
const emit = defineEmits(['add-member', 'remove-member'])
</script>

<template>
    <div class="session"
      :style="`grid-column: track-${slot.rank}; grid-row: ${slot.gridRowStart} / ${slot.gridRowEnd}; background-color: #${slot.bgColorHex}`"
     >
        <h3 class="session-title">{{ slot.name }}</h3>
        <span class="session-time">{{ slot.startHour }}:{{ slot.startMinute }} - {{ slot.endHour }}:{{ slot.endMinute }}</span>
        <span class="session-track">({{ slot.venue }})</span>
        <span class="session-members-needed">{{ slot.members.length }} / {{ slot.membersNeededMin }}</span>
        <div>
            <span class="action add" @click="emit('add-member', slot)">➕</span>
        </div>
        <div class="members">
            <div v-for="member in slot.members" :key="member.id" class="member">
                <span class="action remove" @click="emit('remove-member', slot, member)">❌</span>
                <span>&nbsp;{{ member.fullname }}</span>
            </div>
        </div>
    </div>
</template>

<style scoped>
@import "../assets/slot-item.scss";
</style>
