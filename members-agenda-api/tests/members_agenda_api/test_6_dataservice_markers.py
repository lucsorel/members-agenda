from pydoctrace.doctrace import trace_to_component_puml
from pydoctrace.callfilter.presets import EXCLUDE_STDLIB_PRESET, Preset
from pytest import mark

from members_agenda_api.services.dataservice import DataService

from tests.containers.sql_helper import SqlTestHelper
from tests.containers.sql_files import SQL_FILES_FOLDER

@mark.containers
@mark.skipifnodocker
def test_dataservice_get_venues(monkeypatch, sql_test_helper: SqlTestHelper):
    sql_test_helper.setup_with_sql_filepath(SQL_FILES_FOLDER / 'venues_samples.sql')

    # filter to not trace calls to 3rd party libraries
    FILTER_PYMYSQL_SUBMODULES_PRESET = Preset(
        exclude_call=lambda module_parts, *args: len(module_parts) > 1 and module_parts[0] in {'pymysql'} and module_parts[1] in {'protocol'}
    )

    monkeypatch.setattr(
        'members_agenda_api.services.dataservice.DataService.get_venues',
        trace_to_component_puml(
            export_file_path_tpl='tests/doc/DataService/${function_module}.${function_name}-component.puml',
            filter_presets=(EXCLUDE_STDLIB_PRESET, FILTER_PYMYSQL_SUBMODULES_PRESET)
        )(DataService.get_venues)
    )

    venues = DataService(sql_test_helper.connection).get_venues()
    assert len(venues) == 2
