class IndicatorPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
