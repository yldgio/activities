require 'test_helper'

class TaskCellTest < Cell::TestCase
  test "summary" do
    invoke :summary
    assert_select "p"
  end
  

end
