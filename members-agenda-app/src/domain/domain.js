import { toGridRow, pad2 } from '@/domain/grid'

export class Slot{
    constructor(name, day, startTime, endTime, venue, rank, membersNeededMin, members=[], sessions=[]) {
        this.name = name;
        this.day = day;
        [this.startHour, this.startMinute] = startTime.split(':');
        [this.endHour, this.endMinute] = endTime.split(':');
        this.gridRowStart = toGridRow(Number(this.startHour), Number(this.startMinute));
        this.gridRowEnd = toGridRow(Number(this.endHour), Number(this.endMinute));
        this.venue = venue;
        this.rank = rank;
        this.membersNeededMin = membersNeededMin;
        this.members = members;
        this.sessions = sessions;
    }
    decimalStartHour() {
        return Number(this.startHour) + (Number(this.startMinute) / 60)
    }
    decimalEndHour() {
        return Number(this.endHour) + (Number(this.endMinute) / 60)
    }

    static fromJson(jsonSlot, ranksByVenueName) {
        return new Slot(
            jsonSlot.name,
            jsonSlot.day,
            jsonSlot.startTime,
            jsonSlot.endTime,
            jsonSlot.venue,
            ranksByVenueName[jsonSlot.venue],
            jsonSlot.membersNeededMin,
        )
    }
}

export class Venue {
    constructor(rank, name) {
        this.rank = rank
        this.name = name
    }
    static fromJson(jsonVenue) {
        return new Venue(
            jsonVenue.rank,
            jsonVenue.name,
        )
    }
}
