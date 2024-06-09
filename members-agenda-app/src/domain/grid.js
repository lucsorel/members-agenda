export function range(size, startAt = 0, step = 1) {
    return [...Array(size).keys()].map(index => startAt + (index * step) );
}

export function pad2(value) {
    return `${value}`.padStart(2, '0')
}

export function toGridRow(hour, minute) {
    return `time-${pad2(hour)}${pad2(minute)}`
}
