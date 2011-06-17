require 'helper'

class TestDmeApi < Test::Unit::TestCase

  def setup
    @api = ""
    @secret = ""
    @domain = ""
  end

  def test_requires
    require 'dme-api'
  end

  def test_new
    DME.new(@api, @secret, @domain)
  end

  def test_get
    dme = DME.new(@api, @secret, @domain)
    r = dme.get("www")
    assert r
    assert r.kind_of? Hash
    assert r["name"] == "www"
    assert r["type"] == "CNAME"
    assert r.keys.include? "ttl"
  end

  def test_invalid_domain
    begin
      dme = DME.new(@api, @secret, "foobar")
      r = dme.get("www")
      fail("should have thrown exception")
    rescue => ex
      assert ex.kind_of? RestClient::ResourceNotFound
    end
  end

end
