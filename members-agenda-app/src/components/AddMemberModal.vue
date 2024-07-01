<script setup>
import { ref } from "vue"

const props = defineProps({
  isOpen: Boolean,
  slot: Object,
})

const emit = defineEmits(["modal-close"]);
</script>

<template>
    <div v-if="isOpen" class="modal-mask" @click.stop="emit('modal-close')">
        <div class="modal-wrapper">
            <div class="modal-container" @click.stop.prevent :style="`color: white; background-color: #${slot.bgColorHex};`">
                <div class="modal-header">
                    <slot name="header"> default header </slot>
                </div>
                <div class="modal-body">
                    <slot name="content"> default content </slot>
                </div>
                <div class="modal-footer">
                    <slot name="footer">
                        <div>
                            <button @click.stop="emit('modal-close')">Fermer</button>
                        </div>
                    </slot>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}
.modal-container {
    width: 400px;
    margin: 50px auto;
    padding: 20px 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
}
.modal-footer {
    margin-top: 10px;
}
</style>
