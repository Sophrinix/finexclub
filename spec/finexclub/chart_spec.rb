require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Chart' do
  before do
    @core = mock_core
    @chart = Finexclub::Chart.new(@core)
  end

  describe 'Instance' do
    before do
      @a1, @a2 = mock('a1'), mock('a2')
      @z1, @z2 = mock('z1'), mock('z2')
      @ts = Time.now.to_i
      
      chart_doc = {
        :symbol => 'eurusd',
        :date => '2010-09-08',
        :updated => @ts,
        :alpha => [ @a1, @a2 ],
        :zeta => [ @z1, @z2 ]
      }
      @chart.build(chart_doc)
    end

    it 'should have attribute accessors' do
      @chart.symbol.should == 'eurusd'
      @chart.date.should == '2010-09-08'
      @chart.updated.should == @ts
    end

    it 'should return all alpha signals' do
      @chart.signals(:alpha).should.equal [@a1, @a2]
    end

    it 'should return all zeta signals' do
      @chart.signals(:zeta).should.equal [@z1, @z2]
    end

    it 'should return latest alpha signal as Alpha' do
      Finexclub::Signal.should.receive(:build).with(@core, :alpha, @a2).and_return(a = mock('alpha'))
      @chart.alpha.should == a
    end
    
    it 'should return latest zeta signals as Zeta' do
      Finexclub::Signal.should.receive(:build).with(@core, :zeta, @z2).and_return(z = mock('zeta'))
      @chart.zeta.should == z
    end
  end

end

