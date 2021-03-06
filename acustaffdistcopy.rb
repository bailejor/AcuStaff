def build_header
  stack :width=> "100%", :height=> "20%" do
    background "#EFC"
    border(
      "#BE8",
      :strokewidth => 6
    )
    title(
      "AcuStaff Beta",
      :top => 30,
      :align => "center",
      :font => "Trebuchet MS",
      :stroke => green
    )
	
	$acuity = Hash.new {0}
  end
end

Shoes.app :height=> 500, :width=> 500, :resizeable => false, :title=> "AcuStaff" do
  #Open shoes, set window name and size--------------------------------------
  
  build_header

  #Left side stack and flow-------------------------------------------------
  stack :width=> 270 do
    flow :width => 250, :margin => 1 do
      background "#EFC"
      border(
        "#BE8",
        :strokewidth => 6
      )

      inscription "Room Number:"
      @room_co = edit_line :width => 110

      inscription "Mobility Acuity:"
      @choice_map = {
        "1- Ad lib"       => 1,
        "2- Assist of SB" => 2,
        "3- Assist of 1"  => 3,
        "4- Assist of 2, Complete"  => 4
      }

      @my_listbox = list_box(items: @choice_map.keys, :width => 240)

      inscription "Procedural Acuity:"

      @choice_map2 = {
        "1- No Procedures" => 1,
        "2- IV Starts/Foley Catheter" => 2,
        "3- Post-op/Neuro Checks/Bladder Scans" => 3,
        "4- Bedside Procedure/Frequent Cath/CBI/Trach" => 4
      }

      @my_listbox2 = list_box(items: @choice_map2.keys, :width => 240)

      inscription "Medication Acuity:"

      @choice_map3 = {
        "1- Minimal Oral" => 1,
        "2- Moderate PO/IV" => 2,
        "3- Dysphasia/Multi IV/Insulin" => 3,
        "4- Chemo/GTUBE/Complex IV/PCA/Blood" => 4
      }

      @my_listbox3 = list_box(items: @choice_map3.keys, :width => 240)

      inscription "Nutritional Acuity:"

      @choice_map4 = {
        "1- Self" => 1,
        "2- Setup/Ordering Assistance" => 2,
        "3- Feed" => 3,
        "4- Tubefeed/Aspiration Precautions/TPN" => 4
      }

      @my_listbox4 = list_box(items: @choice_map4.keys, :width => 240)

      inscription "Behavioral Acuity:"

      @choice_map5 = {
        "1- Calls Appropriately/No Needs" => 1,
        "2- Some Education/Calls Occasionally" => 2,
        "3- Anxious/Calls Frequently" => 3,
        "4- New Dx/Calls Very Frequently/Highly Anxious" => 4
      }

      @my_listbox5 = list_box(items: @choice_map5.keys, :width => 240)


      button "Store Patient >" do

        $room = @room_co.text.to_i
        if $room > 6632 then
          alert "Please enter a room between 6601 and 6632"
        elsif $room < 6601 then
          alert "Please enter a room between 6601 and 6632"
        end

        @mobility = @choice_map[@my_listbox.text]
        @procedural = @choice_map2[@my_listbox2.text]
        @medication = @choice_map3[@my_listbox3.text]
        @nutritional = @choice_map4[@my_listbox4.text]
        @behavioral = @choice_map5[@my_listbox5.text]

        @acuity = (@procedural + @nutritional + @medication + @mobility + @behavioral) * 5


        alert "Patient in room #{$room}, is graded at an acuity of #{@acuity}%."

        $acuity[$room] = @acuity


      end




    end
  end
  #End of Left side stack and flow--------------------------------------





  # Right side stack and flow...listboxes for acuity refrences.---------
  stack :width=> 230 do
    flow :width=> 200 do
      background white
      inscription "Notes:"
      edit_box :width => 175, :height => 300



      ##-------------------------------ROSTER------------------------
      button "Show Roster >", :width => 90 do
        window :height=> 500, :width=> 500, :title => "Patient Roster" do
          background "#EFC"
          stack :width=> "100%", :height=> "20%" do
            background "#EFC"
            border(
              "#BE8",
              :strokewidth => 6
            )
            title(
              "AcuStaff Beta",
              :top => 30,
              :align => "center",
              :font => "Trebuchet MS",
              :stroke => green
            )
          end #stack for top portion end

          tagline strong(
            "Save Data for Analysis",
            :stroke => green
          )

          stack :width=> 490 do
            flow :width=> 490, :margin=> 10 do




              @box1 = edit_box :width => 200, :height => 300
              @box1.text = "#{$acuity}"



            end #flow for acuity boxes end
          end #stack for acuity boxes end



          flow do
            button "Load", :width => '50%' do
              file = ask_open_file
              @box1.text = File.read(file)
            end #load button end

            button "Save", :width => '50%' do
              file = ask_save_file
              File.open(file, "w+") do|f|
                f.write @box1.text
              end #file open end
            end #save button end
          end #flow for load/save buttons end



        end #end for window
      end #end for button show roster

      button "Show Floor >", :width => 90 do
        window :height=> 700, :width=> 1200, :title => "Floor Acuity" do
          background "#EFC"

          title(
            "AcuStaff Beta",
            :font => "Trebuchet MS",
            :stroke => green,
            :margin => 35
          )


          # rect top_x, top_y, with, height
          @rect1 = rect 700, 35, 200, 600
          @rect2 = rect 100, 435, 600, 200
          @rect3 = rect 635, 2, 65, 65
          @rect4 = rect 35, 610, 65, 65
          @rect5 = rect 200, 150, 300, 200
          # Rectangle colors
          @rect5.style :fill => "#EFC"
          @rect4.style :fill => lime
          @rect3.style :fill => lime
          @rect1.style :fill => green
          @rect2.style :fill => green

          para(
            "Key:",
            :left => 210,
            :top => 125
          )
          oval(
            :fill => red,
            :left => 220,
            :top => 170,
            :radius => 7
          )
          inscription(
            "Acuity Greater Than 80%",
            :left => 235,
            :top => 170
          )
          oval(
            :fill => orange,
            :left => 220,
            :top => 220,
            :radius => 7
          )
          inscription(
            "Acuity Greater Than 60%",
            :left => 235,
            :top => 220
          )
          oval(
            :fill => yellow,
            :left => 220,
            :top => 270,
            :radius => 7
          )
          inscription(
            "Acuity Greater Than 40%",
            :left => 235,
            :top => 270
          )



          #Rooms
          #North 1
        8.times do |i|
		      top = 440 - 50 * i
			    room_number = 6601 + i
			edit_line(:width => 65, :left => 902, :top => top)
			         .text = "#{room_number}   #{$acuity[room_number]}%"
        end      

          #North 2--------------------------------------------------------------->
          #---------------------------------------------------------------------->
          #---------------------------------------------------------------------->
		  3.times do |i|
		    left = case i
				      when 0
				      	825
				      when 1
				      	715
				      when 2
				      	635
				      end
			  room_number = 6609 + i
		    edit_line(:width => 65, :left => left, :top => 10)
			           .text = "#{room_number}   #{$acuity[room_number]}%"
		  end
      
          #North 3-----------------------------------------------------------------------
          5.times do |i|
            top = 90 + i * 50
            room_number = 6612 + i
          edit_line(:width => 65, :left => 630, :top => top)
                    .text = "#{room_number}   #{$acuity[room_number]}%"
          end
          
          #West 1
		  6.times do |i|
		    right = 600 + i * 90
			room_number = 6617 + i
			edit_line(:width => 65, :right => right, :top => 410)
			         .text = "#{room_number}   #{$acuity[room_number]}%"
		  end

          #West 2
		  3.times do |i|
		    top = case i
				      when 0
				      	470
				      when 1
				      	570
				      when 2
				      	630
				      end
			  room_number = 6623 + i
		    edit_line(:width => 65, :right => 1108, :top => top)
			           .text = "#{room_number}   #{$acuity[room_number]}%"
		  end
      
      #West 3
      7.times do |i|
        right = if i == 0
                  1040
                else
                  1050 - i * 90
                end
        room_number = 6626 + i
        edit_line(:width => 65, :right => right, :top => 640)
                 .text = "#{room_number}   #{$acuity[room_number]}%"
      end
      
          #6601----------------------------------------------------------
          if $acuity[6601] >= 80 then
            oval(
              :left => 970,
              :top => 440,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6601] >= 60
            oval(
              :left => 970,
              :top => 440,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6601] >= 40
            oval(
              :left => 970,
              :top => 440,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6601] == 0
            nil
          end
          #6602----------------------------------------------------------
          if $acuity[6602] >= 80 then
            oval(
              :left => 970,
              :top => 390,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6602] >= 60
            oval(
              :left => 970,
              :top => 390,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6602] >= 40
            oval(
              :left => 970,
              :top => 390,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6602] == 0
            nil
          end
          #6603-----------------------------------------------------------
          if $acuity[6603] >= 80 then
            oval(
              :left => 970,
              :top => 340,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6603] >= 60
            oval(
              :left => 970,
              :top => 340,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6603] >= 40
            oval(
              :left => 970,
              :top => 340,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6603] == 0
            nil
          end
          #6604----------------------------------------------------------
          if $acuity[6604] >= 80 then
            oval(
              :left => 970,
              :top => 290,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6604] >= 60
            oval(
              :left => 970,
              :top => 290,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6604] >= 40
            oval(
              :left => 970,
              :top => 290,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6604] == 0
            nil
          end
          #6605----------------------------------------------------------
          if $acuity[6605] >= 80 then
            oval(
              :left => 970,
              :top => 240,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6605] >= 60
            oval(
              :left => 970,
              :top => 240,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6605] >= 40
            oval(
              :left => 970,
              :top => 240,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6605] == 0
            nil
          end
          #6606----------------------------------------------------------
          if $acuity[6606] >= 80 then
            oval(
              :left => 970,
              :top => 190,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6606] >= 60
            oval(
              :left => 970,
              :top => 190,
              :radius => 7,
              :fill => orange
            )

          elsif $acuity[6606] >= 40
            oval(
              :left => 970,
              :top => 190,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6606] == 0
            nil
          end
          #6607---------------------------------------------------------
          if $acuity[6607] >= 80 then
            oval(
              :left => 970,
              :top => 140,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6607] >= 60
            oval(
              :left => 970,
              :top => 140,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6607] >= 40
            oval(
              :left => 970,
              :top => 140,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6607] == 0
            nil
          end
          #6608----------------------------------------------------------
          if $acuity[6608] >= 80 then
            oval(
              :left => 970,
              :top => 90,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6608] >= 60
            oval(
              :left => 970,
              :top => 90,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6608] >= 40
            oval(
              :left => 970,
              :top => 90,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6608] == 0
            nil

          end
          #6609----------------------------------------------------------
          if $acuity[6609] >= 80 then
            oval(
              :left => 895,
              :top => 12,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6609] >= 60
            oval(
              :left => 895,
              :top => 12,
              :radius => 7,
              :fill => orange
            )

          elsif $acuity[6609] >= 40
            oval(
              :left => 895,
              :top => 12,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6609] == 0
            nil
          end
          #6610---------------------------------------------------------
          if $acuity[6610] >= 80 then
            oval(
              :left => 785,
              :top => 12,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6610] >= 60
            oval(
              :left => 785,
              :top => 12,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6610] >= 40
            oval(
              :left => 785,
              :top => 12,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6610] == 0
            nil
          end
          #6611----------------------------------------------------------
          if $acuity[6611] >= 80 then
            oval(
              :left => 615,
              :top => 12,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6611] >= 60
            oval(
              :left => 615,
              :top => 12,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6611] >= 40
            oval(
              :left => 615,
              :top => 12,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6611] == 0
            nil

          end
          #6612--------------------------------------------------------------
          if $acuity[6612] >= 80 then
            oval(
              :left => 610,
              :top => 93,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6612] >= 60
            oval(
              :left => 610,
              :top => 93,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6612] >= 40
            oval(
              :left => 610,
              :top => 93,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6612] == 0
            nil
          end
          #6613----------------------------------------------------------
          if $acuity[6613] >= 80 then
            oval(
              :left => 610,
              :top => 142,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6613] >= 60
            oval(
              :left => 610,
              :top => 142,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6613] >= 40
            oval(
              :left => 610,
              :top => 142,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6613] == 0
            nil
          end
          #6614-----------------------------------------------------------
          if $acuity[6614] >= 80 then
            oval(
              :left => 610,
              :top => 192,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6614] >= 60
            oval(
              :left => 610,
              :top => 192,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6614] >= 40
            oval(
              :left => 610,
              :top => 192,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6614] == 0
            nil
          end
          #6615----------------------------------------------------------
          if $acuity[6615] >= 80 then
            oval(
              :left => 610,
              :top => 242,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6615] >= 60
            oval(
              :left => 610,
              :top => 242,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6615] >= 40
            oval(
              :left => 610,
              :top => 242,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6615] == 0
            nil
          end
          #6616----------------------------------------------------------
          if $acuity[6616] >= 80 then
            oval(
              :left => 610,
              :top => 292,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6616] >= 60
            oval(
              :left => 610,
              :top => 292,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6616] >= 40
            oval(
              :left => 610,
              :top => 292,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6616] == 0
            nil
          end
          #6617--------------------------------------------------------------
          if $acuity[6617] >= 80 then
            oval(
              :left => 565,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6617] >= 60
            oval(
              :left => 565,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6617] >= 40
            oval(
              :left => 565,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6617] == 0
            nil
          end
          #6618----------------------------------------------------------
          if $acuity[6618] >= 80 then
            oval(
              :left => 475,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6618] >= 60
            oval(
              :left => 475,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6618] >= 40
            oval(
              :left => 475,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6618] == 0
            nil
          end
          #6619-----------------------------------------------------------
          if $acuity[6619] >= 80 then
            oval(
              :left => 385,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6619] >= 60
            oval(
              :left => 385,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6619] >= 40
            oval(
              :left => 385,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6619] == 0
            nil
          end
          #6620----------------------------------------------------------
          if $acuity[6620] >= 80 then
            oval(
              :left => 295,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6620] >= 60
            oval(
              :left => 295,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6620] >= 40
            oval(
              :left => 295,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6620] == 0
            nil
          end
          #6621----------------------------------------------------------
          if $acuity[6621] >= 80 then
            oval(
              :left => 205,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6621] >= 60
            oval(
              :left => 205,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6621] >= 40
            oval(
              :left => 205,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6621] == 0
            nil
          end

          #6622----------------------------------------------------------
          if $acuity[6622] >= 80 then
            oval(
              :left => 120,
              :top => 392,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6622] >= 60
            oval(
              :left => 120,
              :top => 392,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6622] >= 40
            oval(
              :left => 120,
              :top => 392,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6622] == 0
            nil
          end

          #6623----------------------------------------------------------
          if $acuity[6623] >= 80 then
            oval(
              :left => 15,
              :top => 472,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6623] >= 60
            oval(
              :left => 15,
              :top => 472,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6623] >= 40
            oval(
              :left => 15,
              :top => 472,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6623] == 0
            nil
          end
          #6624----------------------------------------------------------
          if $acuity[6624] >= 80 then
            oval(
              :left => 15,
              :top => 572,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6624] >= 60
            oval(
              :left => 15,
              :top => 572,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6624] >= 40
            oval(
              :left => 15,
              :top => 572,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6624] == 0
            nil
          end

          #6625----------------------------------------------------------
          if $acuity[6625] >= 80 then
            oval(
              :left => 15,
              :top => 632,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6625] >= 60
            oval(
              :left => 15,
              :top => 632,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6625] >= 40
            oval(
              :left => 15,
              :top => 632,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6625] == 0
            nil
          end

          #6626-----------------------------------------------------------
          if $acuity[6626] >= 80 then
            oval(
              :left => 125,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6626] >= 60
            oval(
              :left => 125,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6626] >= 40
            oval(
              :left => 125,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6626] == 0
            nil
          end
          #6627----------------------------------------------------------
          if $acuity[6627] >= 80 then
            oval(
              :left => 205,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6627] >= 60
            oval(
              :left => 205,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6627] >= 40
            oval(
              :left => 205,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6627] == 0
            nil
          end
          #6628----------------------------------------------------------
          if $acuity[6628] >= 80 then
            oval(
              :left => 295,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6628] >= 60
            oval(
              :left => 295,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6628] >= 40
            oval(
              :left => 295,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6628] == 0
            nil
          end

          #6629----------------------------------------------------------
          if $acuity[6629] >= 80 then
            oval(
              :left => 385,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6629] >= 60
            oval(
              :left => 385,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6629] >= 40
            oval(
              :left => 385,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6629] == 0
            nil
          end

          #6630----------------------------------------------------------
          if $acuity[6630] >= 80 then
            oval(
              :left => 475,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6630] >= 60
            oval(
              :left => 475,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6630] >= 40
            oval(
              :left => 475,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6630] == 0
            nil
          end
          #6631----------------------------------------------------------
          if $acuity[6631] >= 80 then
            oval(
              :left => 565,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6631] >= 60
            oval(
              :left => 565,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6631] >= 40
            oval(
              :left => 565,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6631] == 0
            nil
          end

          #6632----------------------------------------------------------
          if $acuity[6632] >= 80 then
            oval(
              :left => 655,
              :top => 665,
              :radius => 7,
              :fill => red
            )
          elsif $acuity[6632] >= 60
            oval(
              :left => 655,
              :top => 665,
              :radius => 7,
              :fill => orange
            )
          elsif $acuity[6632] >= 40
            oval(
              :left => 655,
              :top => 665,
              :radius => 7,
              :fill => yellow
            )
          elsif $acuity[6632] == 0
            nil
          end






        end #end for floor button
      end	 #end for floor window


    end #end of flow for notes and roster button
  end #end of stack for notes and roster button






end #end of program
