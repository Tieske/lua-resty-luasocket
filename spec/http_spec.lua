
describe('resty.luasocket', function()

  it('loads the http module', function()
    local httpc = require 'resty.luasocket.http'
    assert.is_function(httpc.request)
  end)

end)
