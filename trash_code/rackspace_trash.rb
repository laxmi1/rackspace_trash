require File.dirname(__FILE__) +  '/../test_helper.rb'


class Login < Test::Unit::TestCase 
  fixtures :users

  def setup
    @driver = get_driver
    @accept_next_alert = true
    @verification_errors = [] 
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  

  def test_rackspace_trash
    @driver.get(@base_url + "/")
    @driver.find_element(:css, 'input[name="user_name"]').clear
    @driver.find_element(:id, "user_session_email").send_keys ""
    @driver.find_element(:id, "user_session_email").send_keys @user_name
    @driver.find_element(:id, "user_session_password").clear
    @driver.find_element(:id, "user_session_password").send_keys ""
    @driver.find_element(:id, 'input[name="password"]').send_keys @password 
    @driver.find_element(:css, "button.button").click
    assert_equal "Demo", @driver.find_element(:css, "h1.store_name").text
  end


  def element_present?(how, what)
    @driver.find_element(how, what)
    true
      rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

# To see the alert is present and throws an error if no alert is present
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
# To verify expected and actual values
# If assertion failed it throws an error
  def verify(&blk)
    yield
    rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
# To close alerts
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
    ensure
    @accept_next_alert = true
  end
end
