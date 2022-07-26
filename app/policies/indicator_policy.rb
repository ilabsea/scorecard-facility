class IndicatorPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    destroy?
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

  def upload?
    %w(Indicators::ProgramIndicator Indicators::CustomIndicator).include? record.type
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
