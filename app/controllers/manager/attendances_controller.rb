class Manager::AttendancesController < ApplicationController
  before_action :authenticate_user!

def index
  @agents = current_user.department.agents
end
end
