import { toGridRow } from '@/domain/grid'

// generates a kind of unique id based on the contents provided
function hash(...values) {
    const contents = values.reduce((text, value) => `${text}${value}`, '')
    return contents.split('').reduce((hash, character) => (((hash << 5) - hash) + character) | 0, 0)
}

export class Slot{
    constructor(id, name, day, startTime, endTime, venue, bgColorHex, rank, membersNeededMin, members=[], sessions=[]) {
        this.id = id
        this.name = name;
        this.day = day;
        [this.startHour, this.startMinute] = startTime.split(':');
        [this.endHour, this.endMinute] = endTime.split(':');
        this.gridRowStart = toGridRow(Number(this.startHour), Number(this.startMinute));
        this.gridRowEnd = toGridRow(Number(this.endHour), Number(this.endMinute));
        this.venue = venue;
        this.bgColorHex = bgColorHex;
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

    static fromApiJson(jsonSlot, venues, ranksByVenueName, membersById, assignments) {
        const [startDay, startTime] = jsonSlot.start.split('T')
        const [, endTime] = jsonSlot.end.split('T')
        const venue = venues.find(item => item.id === jsonSlot.venue_id)

        const slotAssignments = assignments.filter(assignment => assignment.slotId == jsonSlot.id)
        const slotMembers = slotAssignments.map(assignment => membersById[assignment.memberId])

        return new Slot(
            jsonSlot.id,
            jsonSlot.title,
            startDay,
            startTime,
            endTime,
            venue.name,
            venue.bgColorHex,
            ranksByVenueName[venue.name],
            jsonSlot.needed_members_nb,
            slotMembers,
        )
    }
}

export class Venue {
    constructor(id, name, rank, bgColorHex) {
        this.id = id
        this.name = name
        this.rank = rank
        this.bgColorHex = bgColorHex
    }

    static fromApiJson(jsonVenue) {
        return new Venue(
            jsonVenue.id,
            jsonVenue.name,
            jsonVenue.rank,
            jsonVenue.bg_color_hex,
        )
    }
}

export class Member {
    constructor(id, fullname) {
        this.id = id
        this.fullname = fullname
    }

    static fromApiJson(jsonMember) {
        return new Member(
            jsonMember.id,
            jsonMember.fullname,
        )
    }
}

export class Assignment {
    constructor(slotId, memberId) {
        this.slotId = slotId
        this.memberId = memberId
    }

    static fromApiJson(jsonAssignment) {
        return new Assignment(
            jsonAssignment.slot_id,
            jsonAssignment.member_id,
        )
    }
}
