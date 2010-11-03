require 'rho/rhocontroller'

class NativeBarTestController < Rho::RhoController

  def save_location
    location = WebView.current_location
    puts "location: #{location}"
    @@this_page = location
  end

  def set_no_bar
    save_location
    NativeBar.create(Rho::RhoApplication::NOBAR_TYPE, [])
    $tabbar_active = false
    render :action => :index
  end

  def set_toolbar
    save_location
    toolbar = [
      {:action => :back,    :icon => '/public/images/bar/back_btn.png'},
      {:action => :forward, :icon => '/public/images/bar/forward_btn.png'},
      {:action => :separator},
      {:action => :home,    :icon => '/public/images/bar/colored_btn.png' :colored_icon => true},
      {:action => :refresh },
      {:action => 'callback:' + url_for(:action => :callback), :label => 'Callback' },
      {:action => :options}
    ]
    NativeBar.create(Rho::RhoApplication::TOOLBAR_TYPE, toolbar)
    $tabbar_active = false
    render :action => :index
  end

  def set_tabbar
    save_location
    tabbar = [
      {:label => 'Native bar', :action => '/app/NativeBarTest', :icon => '/public/images/bar/gears.png',    :reload => true},
      {:label => 'Main page',  :action => '/app',               :icon => '/public/images/bar/home_btn.png', :reload => true},
      {:label => 'Main page 2', :action => 'callback:' + url_for(:action => :show_main_page), :icon => '/public/images/bar/home_btn.png', :reload => true}
    ]
    NativeBar.create(Rho::RhoApplication::TABBAR_TYPE, tabbar)
    $tabbar_active = true
    NativeBar.switch_tab(0)
  end

  def show_main_page
    WebView.navigate '/app'
  end

  def set_iPad_tabbar
    save_location
    tabbar = [
      {:label => 'Native bar', :action => '/app/NativeBarTest', :icon => '/public/images/bar/gears.png',    :reload => true},
      {:label => 'Main page',  :action => '/app',               :icon => '/public/images/bar/home_btn.png', :reload => true},
      {:label => 'Main page 2', :action => 'callback:' + url_for(:action => :show_main_page), :icon => '/public/images/bar/home_btn.png', :reload => true}
    ]
    NativeBar.create(Rho::RhoApplication:: VTABBAR_TYPE, tabbar)
    $tabbar_active = true
    NativeBar.switch_tab(0)
  end

  def switch_to_tab_1
    NativeBar.switch_tab(1)
  end

  def switch_to_tab_2
    NativeBar.switch_tab(2)
  end

  def callback
    puts "+++--- callback"
    WebView.navigate '/app'
  end

end
