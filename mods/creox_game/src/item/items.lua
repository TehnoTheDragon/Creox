local Builder = creox.game.Builder.Item

--> Items
Builder.create_item("wood_plank").texture("wood_plank.png").max_stack(16).build()
Builder.create_item("wood_stick").texture("wood_stick.png").max_stack(64).build()
Builder.create_item("processed_wood_stick").texture("processed_wood_stick.png").max_stack(64).build()
Builder.create_item("emerald").texture("faceted_jewelry_1.png").max_stack(16).build()