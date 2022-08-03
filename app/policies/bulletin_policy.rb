# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def new?
    user
  end

  def update?
    @record&.user_id == user&.id || user&.admin?
  end

  def edit?
    @record&.user_id == user&.id || user&.admin?
  end

  def destroy?
    user&.admin?
  end
end
