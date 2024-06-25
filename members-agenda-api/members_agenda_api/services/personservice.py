from fastapi import HTTPException, Response, status
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder

from members_agenda_api.domain import AlreadyInvolvedResponse, Person
from members_agenda_api.services.dataservice import DataService
from members_agenda_api.validation import validate_positive_int

class PersonService:
    def __init__(self, data_service: DataService):
        self.data_service = data_service

    def get_person(self, person_id: int) -> Person:
        validate_positive_int(person_id)

        person = self.data_service.get_person(person_id)
        if person is None:
            raise HTTPException(status_code=404, detail=f'nobody with id {person_id}')
        else:
            return person

    def get_members(self) -> list[Person]:
        return self.data_service.get_members()

    def add_member_to_slot(self, member_id: int, slot_id: int, response: Response) -> int:
        person = self.data_service.get_person(member_id)
        if person is None:
            raise HTTPException(status_code=404, detail=f'nobody with id {member_id}')
        if not person.is_member:
            raise HTTPException(status_code=405, detail=f'person of id {member_id} is not a member')

        slot, existing_members = self.data_service.get_slot_with_members(slot_id)
        if slot is None:
            raise HTTPException(status_code=404, detail=f'no slot with id {slot_id}')

        # exits here if the member is already added to the slot
        already_member = any(slot_member.id == member_id for slot_member in existing_members)
        if already_member:
            response.status_code = status.HTTP_200_OK
            return 0

        # verifies that the person is not a speaker in an event nor a member in another slot during the period
        member_slots, speaker_events = self.data_service.get_active_slots_and_events(member_id, slot.start, slot.end)
        if member_slots or speaker_events:
            return JSONResponse(
                content=jsonable_encoder(AlreadyInvolvedResponse(
                    message="person already involved during this period",
                    member_slots=member_slots,
                    speaker_events=speaker_events
                )),
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

        # adds the member to the slot
        return self.data_service.add_member_to_slot(member_id, slot_id)
