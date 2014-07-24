load File.dirname(__FILE__) +  '/../test_helper.rb'
#require './test_helper.rb'

class Login < Test::Unit::TestCase 

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
    url = APPLICATION_CONFIG["base_url"] 
    puts "reading.. "+url+".. end"
    #@driver.get("https://apps.rackspace.com")
    @driver.get(@base_url)
    @driver.find_element(:name,"user_name").send_keys APPLICATION_CONFIG["user_name"]
    @driver.find_element(:name,"password").send_keys APPLICATION_CONFIG["pass_word"]
    @driver.find_element(:name,"submit_btn").click
    #wait_for_ajax(@driver)
    sleep(10)
    @driver.find_element(:xpath,"//img[@class='icon folder_inbox']").click
    @i = 0
    while(@i < 2)
      puts @i
    @initial = @driver.find_element(:css,".counter>div").text.split(" ")[4].to_i
    
    @driver.find_element(:css, ".fill_height.last").click
    sleep(20)
    @driver.find_element(:xpath,"//*[@id='wm_core_toolbar']/div/div/ul/li[5]/div/div[2]").click
    sleep(6)
    @driver.find_element(:css, ".checkbox>div>input").click
    #@driver.find_element(:css, ".container.delete").click
    sleep(10)
    @actual = @driver.find_element(:css,".counter>div").text.split(" ")[4].to_i
    puts "actual is : #{@actual} and previous is : #{@initial}"
    if(@actual != @initial)
      @cond = true
      @i = @i+1
      puts "inside if"
    else
      @cond = false
      puts "inside else"
    end
  end
    #wait_for_ajax(@driver)

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
