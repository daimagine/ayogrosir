class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
    	t.string :ip_address
    	t.references :resource, :polymorphic => true
      t.timestamps
    end
  end
end
