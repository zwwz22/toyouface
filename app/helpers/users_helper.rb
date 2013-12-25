module UsersHelper

  def old_name(name)
    name.collect {|u| url_for users_path(:name => u)}
  end
end
