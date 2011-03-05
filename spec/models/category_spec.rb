# coding: utf-8
require File.dirname(__FILE__) + "/../spec_helper"

describe Category do
  describe "should set name from commision name on create" do
    it { Category.create(:commission_name => "Comisión de Agricultura").name.should == "Agricultura" }
    it { Category.create(:commission_name => "Comisión del Estatuto de los Diputados").name.should == "Estatuto de los Diputados" }
    it { Category.create(:commission_name => "Comisión Mixta para la Unión Europea").name.should == "Unión Europea" }
    it { Category.create(:commission_name => "Comisión para las políticas integrales de la discapacidad").name.should == "Políticas integrales de la discapacidad" }
    it { Category.create(:commission_name => "Comisión Constitucional").name.should == "Constitucional" }
  end
end