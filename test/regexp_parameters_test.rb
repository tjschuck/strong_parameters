require 'test_helper'
require 'action_controller/parameters'

class RegexpParametersTest < ActiveSupport::TestCase
  test "permitted parameters defined by regexp" do
    params = ActionController::Parameters.new({
      object_1: {
        safe_param_1: 'value',
        safe_param_2: 'value',
        malicious: 'haxored!'
      },
      object_2: {
        safe_param_1: 'value',
        safe_param_2: 'value',
        malicious: 'haxored!'
      },
      bad_object: {
        param: 'value'
      }
    })

    expected = ActionController::Parameters.new({
      object_1: {
        safe_param_1: 'value',
        safe_param_2: 'value'
      },
      object_2: {
        safe_param_1: 'value',
        safe_param_2: 'value'
      }
    })

    permitted = params.permit(/^object_\d$/ => [/^safe_param_\d$/])
    assert_equal expected, permitted 
  end
end
