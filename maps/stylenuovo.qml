<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" labelsEnabled="0" simplifyLocal="1" readOnly="0" maxScale="0" simplifyAlgorithm="0" simplifyMaxScale="1" hasScaleBasedVisibilityFlag="0" minScale="1e+08" version="3.4.14-Madeira" simplifyDrawingTol="1" simplifyDrawingHints="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 type="RuleRenderer" enableorderby="0" forceraster="0" symbollevels="0">
    <rules key="{7497590b-1712-4f33-a7f5-d42c79467ee3}">
      <rule label="No electrification taking place" key="{143644a0-b654-487e-a70c-0c357a5b6584}" symbol="0" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) &lt; 0.000000 AND (&quot;elctrpp&quot;&lt;=0)"/>
      <rule label="Electr. up to 75% slower than pop. growth" key="{e5ae452b-fe2b-40c9-8bb2-15f746380e7f}" symbol="1" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 0.250000"/>
      <rule label="Electr. up to 50% slower than pop. growth" key="{c7200df7-9fa4-411f-b209-2581af0b449c}" symbol="2" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.250000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 0.750000"/>
      <rule label="Electr. up to 25% slower than pop. growth" key="{c0039e61-0e60-4d0b-baf1-de309908e5b8}" symbol="3" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.750000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.000000"/>
      <rule label="Same pace" key="{ff5179f5-5674-4cc6-9c29-1acf30006575}" symbol="4" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.000000"/>
      <rule label="Electr. up to 25% faster than pop. growth" key="{e90c8d2a-eeb2-44db-b4db-cafa7fd26531}" symbol="5" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.250000"/>
      <rule label="Electr. up to 50% faster than pop. growth" key="{5c453161-ba76-4d9b-a6ed-40013e8adf27}" symbol="6" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.250000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.500000"/>
      <rule label="Electr. up to 75% faster than pop. growth" key="{0d419c15-1fd7-49ca-909f-70a100b3062d}" symbol="7" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.500000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 185.138858"/>
      <rule label="On a pathway to full electrification" key="{212f90cb-b23b-4e24-b4f7-f48d5b74d7a4}" symbol="8" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) &lt; 0.000000 AND (&quot;popchng&quot;&lt;=0)"/>
    </rules>
    <symbols>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="0">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="226,34,27,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="1">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="226,94,88,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="2">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="245,177,147,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="3">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="247,224,214,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="4">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="255,255,255,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="5">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="161,204,226,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="6">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="85,161,203,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="7">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="5,113,176,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" alpha="1" name="8">
        <layer enabled="1" locked="0" class="SimpleFill" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="5,113,78,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <customproperties>
    <property key="dualview/previewExpressions" value="GID_1"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory sizeScale="3x:0,0,0,0,0,0" enabled="0" penColor="#000000" width="15" scaleDependency="Area" diagramOrientation="Up" opacity="1" rotationOffset="270" backgroundColor="#ffffff" penAlpha="255" minimumSize="0" height="15" minScaleDenominator="0" backgroundAlpha="255" penWidth="0" lineSizeType="MM" lineSizeScale="3x:0,0,0,0,0,0" barWidth="5" sizeType="MM" maxScaleDenominator="1e+08" labelPlacementMethod="XHeight" scaleBasedVisibility="0">
      <fontProperties style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      <attribute label="" field="" color="#000000"/>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings dist="0" showAll="1" priority="0" linePlacementFlags="18" placement="1" zIndex="0" obstacle="0">
    <properties>
      <Option type="Map">
        <Option type="QString" name="name" value=""/>
        <Option name="properties"/>
        <Option type="QString" name="type" value="collection"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions removeDuplicateNodes="0" geometryPrecision="0">
    <activeChecks/>
    <checkConfiguration/>
  </geometryOptions>
  <fieldConfiguration>
    <field name="GID_1">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="GID_0">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_0">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_1">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="VARNAME_1">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="systm_ndx_">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="GID_0_x">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_0_x">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_1_x">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="VARNAME_1_">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop14">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop15">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop16">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop17">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop18">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="pop19">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="_ge_x">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="systm_nd_1">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="GID_0_y">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_0_y">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="NAME_1_y">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="VARNAME__1">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc14">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc15">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc16">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc17">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc18">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="ncc19">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="_ge_y">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr19">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr18">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr17">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr16">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr15">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elr14">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="eldff">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elctrpp">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="popchng">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="GID_1" index="0" name=""/>
    <alias field="GID_0" index="1" name=""/>
    <alias field="NAME_0" index="2" name=""/>
    <alias field="NAME_1" index="3" name=""/>
    <alias field="VARNAME_1" index="4" name=""/>
    <alias field="systm_ndx_" index="5" name=""/>
    <alias field="GID_0_x" index="6" name=""/>
    <alias field="NAME_0_x" index="7" name=""/>
    <alias field="NAME_1_x" index="8" name=""/>
    <alias field="VARNAME_1_" index="9" name=""/>
    <alias field="pop14" index="10" name=""/>
    <alias field="pop15" index="11" name=""/>
    <alias field="pop16" index="12" name=""/>
    <alias field="pop17" index="13" name=""/>
    <alias field="pop18" index="14" name=""/>
    <alias field="pop19" index="15" name=""/>
    <alias field="_ge_x" index="16" name=""/>
    <alias field="systm_nd_1" index="17" name=""/>
    <alias field="GID_0_y" index="18" name=""/>
    <alias field="NAME_0_y" index="19" name=""/>
    <alias field="NAME_1_y" index="20" name=""/>
    <alias field="VARNAME__1" index="21" name=""/>
    <alias field="ncc14" index="22" name=""/>
    <alias field="ncc15" index="23" name=""/>
    <alias field="ncc16" index="24" name=""/>
    <alias field="ncc17" index="25" name=""/>
    <alias field="ncc18" index="26" name=""/>
    <alias field="ncc19" index="27" name=""/>
    <alias field="_ge_y" index="28" name=""/>
    <alias field="elr19" index="29" name=""/>
    <alias field="elr18" index="30" name=""/>
    <alias field="elr17" index="31" name=""/>
    <alias field="elr16" index="32" name=""/>
    <alias field="elr15" index="33" name=""/>
    <alias field="elr14" index="34" name=""/>
    <alias field="eldff" index="35" name=""/>
    <alias field="elctrpp" index="36" name=""/>
    <alias field="popchng" index="37" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="GID_1" applyOnUpdate="0" expression=""/>
    <default field="GID_0" applyOnUpdate="0" expression=""/>
    <default field="NAME_0" applyOnUpdate="0" expression=""/>
    <default field="NAME_1" applyOnUpdate="0" expression=""/>
    <default field="VARNAME_1" applyOnUpdate="0" expression=""/>
    <default field="systm_ndx_" applyOnUpdate="0" expression=""/>
    <default field="GID_0_x" applyOnUpdate="0" expression=""/>
    <default field="NAME_0_x" applyOnUpdate="0" expression=""/>
    <default field="NAME_1_x" applyOnUpdate="0" expression=""/>
    <default field="VARNAME_1_" applyOnUpdate="0" expression=""/>
    <default field="pop14" applyOnUpdate="0" expression=""/>
    <default field="pop15" applyOnUpdate="0" expression=""/>
    <default field="pop16" applyOnUpdate="0" expression=""/>
    <default field="pop17" applyOnUpdate="0" expression=""/>
    <default field="pop18" applyOnUpdate="0" expression=""/>
    <default field="pop19" applyOnUpdate="0" expression=""/>
    <default field="_ge_x" applyOnUpdate="0" expression=""/>
    <default field="systm_nd_1" applyOnUpdate="0" expression=""/>
    <default field="GID_0_y" applyOnUpdate="0" expression=""/>
    <default field="NAME_0_y" applyOnUpdate="0" expression=""/>
    <default field="NAME_1_y" applyOnUpdate="0" expression=""/>
    <default field="VARNAME__1" applyOnUpdate="0" expression=""/>
    <default field="ncc14" applyOnUpdate="0" expression=""/>
    <default field="ncc15" applyOnUpdate="0" expression=""/>
    <default field="ncc16" applyOnUpdate="0" expression=""/>
    <default field="ncc17" applyOnUpdate="0" expression=""/>
    <default field="ncc18" applyOnUpdate="0" expression=""/>
    <default field="ncc19" applyOnUpdate="0" expression=""/>
    <default field="_ge_y" applyOnUpdate="0" expression=""/>
    <default field="elr19" applyOnUpdate="0" expression=""/>
    <default field="elr18" applyOnUpdate="0" expression=""/>
    <default field="elr17" applyOnUpdate="0" expression=""/>
    <default field="elr16" applyOnUpdate="0" expression=""/>
    <default field="elr15" applyOnUpdate="0" expression=""/>
    <default field="elr14" applyOnUpdate="0" expression=""/>
    <default field="eldff" applyOnUpdate="0" expression=""/>
    <default field="elctrpp" applyOnUpdate="0" expression=""/>
    <default field="popchng" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="GID_1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="GID_0" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_0" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="VARNAME_1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="systm_ndx_" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="GID_0_x" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_0_x" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_1_x" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="VARNAME_1_" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop14" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop15" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop16" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop17" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop18" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="pop19" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="_ge_x" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="systm_nd_1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="GID_0_y" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_0_y" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="NAME_1_y" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="VARNAME__1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc14" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc15" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc16" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc17" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc18" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="ncc19" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="_ge_y" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr19" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr18" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr17" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr16" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr15" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elr14" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="eldff" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="elctrpp" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="popchng" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="GID_1" desc=""/>
    <constraint exp="" field="GID_0" desc=""/>
    <constraint exp="" field="NAME_0" desc=""/>
    <constraint exp="" field="NAME_1" desc=""/>
    <constraint exp="" field="VARNAME_1" desc=""/>
    <constraint exp="" field="systm_ndx_" desc=""/>
    <constraint exp="" field="GID_0_x" desc=""/>
    <constraint exp="" field="NAME_0_x" desc=""/>
    <constraint exp="" field="NAME_1_x" desc=""/>
    <constraint exp="" field="VARNAME_1_" desc=""/>
    <constraint exp="" field="pop14" desc=""/>
    <constraint exp="" field="pop15" desc=""/>
    <constraint exp="" field="pop16" desc=""/>
    <constraint exp="" field="pop17" desc=""/>
    <constraint exp="" field="pop18" desc=""/>
    <constraint exp="" field="pop19" desc=""/>
    <constraint exp="" field="_ge_x" desc=""/>
    <constraint exp="" field="systm_nd_1" desc=""/>
    <constraint exp="" field="GID_0_y" desc=""/>
    <constraint exp="" field="NAME_0_y" desc=""/>
    <constraint exp="" field="NAME_1_y" desc=""/>
    <constraint exp="" field="VARNAME__1" desc=""/>
    <constraint exp="" field="ncc14" desc=""/>
    <constraint exp="" field="ncc15" desc=""/>
    <constraint exp="" field="ncc16" desc=""/>
    <constraint exp="" field="ncc17" desc=""/>
    <constraint exp="" field="ncc18" desc=""/>
    <constraint exp="" field="ncc19" desc=""/>
    <constraint exp="" field="_ge_y" desc=""/>
    <constraint exp="" field="elr19" desc=""/>
    <constraint exp="" field="elr18" desc=""/>
    <constraint exp="" field="elr17" desc=""/>
    <constraint exp="" field="elr16" desc=""/>
    <constraint exp="" field="elr15" desc=""/>
    <constraint exp="" field="elr14" desc=""/>
    <constraint exp="" field="eldff" desc=""/>
    <constraint exp="" field="elctrpp" desc=""/>
    <constraint exp="" field="popchng" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{00000000-0000-0000-0000-000000000000}"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column width="-1" type="field" name="GID_1" hidden="0"/>
      <column width="-1" type="field" name="GID_0_x" hidden="0"/>
      <column width="-1" type="field" name="NAME_0" hidden="0"/>
      <column width="-1" type="field" name="NAME_1" hidden="0"/>
      <column width="-1" type="field" name="GID_0_y" hidden="0"/>
      <column width="-1" type="field" name="pop18" hidden="0"/>
      <column width="-1" type="field" name="pop14" hidden="0"/>
      <column width="-1" type="field" name="elctrpp" hidden="0"/>
      <column width="-1" type="field" name="popchng" hidden="0"/>
      <column width="-1" type="actions" hidden="1"/>
      <column width="-1" type="field" name="GID_0" hidden="0"/>
      <column width="-1" type="field" name="VARNAME_1" hidden="0"/>
      <column width="-1" type="field" name="systm_ndx_" hidden="0"/>
      <column width="-1" type="field" name="NAME_0_x" hidden="0"/>
      <column width="-1" type="field" name="NAME_1_x" hidden="0"/>
      <column width="-1" type="field" name="VARNAME_1_" hidden="0"/>
      <column width="-1" type="field" name="pop15" hidden="0"/>
      <column width="-1" type="field" name="pop16" hidden="0"/>
      <column width="-1" type="field" name="pop17" hidden="0"/>
      <column width="-1" type="field" name="pop19" hidden="0"/>
      <column width="-1" type="field" name="_ge_x" hidden="0"/>
      <column width="-1" type="field" name="systm_nd_1" hidden="0"/>
      <column width="-1" type="field" name="NAME_0_y" hidden="0"/>
      <column width="-1" type="field" name="NAME_1_y" hidden="0"/>
      <column width="-1" type="field" name="VARNAME__1" hidden="0"/>
      <column width="-1" type="field" name="ncc14" hidden="0"/>
      <column width="-1" type="field" name="ncc15" hidden="0"/>
      <column width="-1" type="field" name="ncc16" hidden="0"/>
      <column width="-1" type="field" name="ncc17" hidden="0"/>
      <column width="-1" type="field" name="ncc18" hidden="0"/>
      <column width="-1" type="field" name="ncc19" hidden="0"/>
      <column width="-1" type="field" name="_ge_y" hidden="0"/>
      <column width="-1" type="field" name="elr19" hidden="0"/>
      <column width="-1" type="field" name="elr18" hidden="0"/>
      <column width="-1" type="field" name="elr17" hidden="0"/>
      <column width="-1" type="field" name="elr16" hidden="0"/>
      <column width="-1" type="field" name="elr15" hidden="0"/>
      <column width="-1" type="field" name="elr14" hidden="0"/>
      <column width="-1" type="field" name="eldff" hidden="0"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
I form QGIS possono avere una funzione Python che può essere chiamata quando un form viene aperto.

Usa questa funzione per aggiungere logica extra ai tuoi forms..

Inserisci il nome della funzione nel campo "Funzione Python di avvio".

Segue un esempio:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="Area" editable="1"/>
    <field name="GID_0" editable="1"/>
    <field name="GID_0_x" editable="1"/>
    <field name="GID_0_y" editable="1"/>
    <field name="GID_1" editable="1"/>
    <field name="NAME_0" editable="1"/>
    <field name="NAME_0_x" editable="1"/>
    <field name="NAME_0_y" editable="1"/>
    <field name="NAME_1" editable="1"/>
    <field name="NAME_1_x" editable="1"/>
    <field name="NAME_1_y" editable="1"/>
    <field name="VARNAME" editable="1"/>
    <field name="VARNAME_1" editable="1"/>
    <field name="VARNAME_1_" editable="1"/>
    <field name="VARNAME__1" editable="1"/>
    <field name="_ge_x" editable="1"/>
    <field name="_ge_y" editable="1"/>
    <field name="cats" editable="1"/>
    <field name="elctrpp" editable="1"/>
    <field name="eldff" editable="1"/>
    <field name="eldffpc" editable="1"/>
    <field name="eldiff" editable="1"/>
    <field name="elr14" editable="1"/>
    <field name="elr15" editable="1"/>
    <field name="elr16" editable="1"/>
    <field name="elr17" editable="1"/>
    <field name="elr18" editable="1"/>
    <field name="elr19" editable="1"/>
    <field name="elrat14" editable="1"/>
    <field name="elrat16" editable="1"/>
    <field name="elrat18" editable="1"/>
    <field name="ncc14" editable="1"/>
    <field name="ncc15" editable="1"/>
    <field name="ncc16" editable="1"/>
    <field name="ncc17" editable="1"/>
    <field name="ncc18" editable="1"/>
    <field name="ncc19" editable="1"/>
    <field name="pop14" editable="1"/>
    <field name="pop15" editable="1"/>
    <field name="pop16" editable="1"/>
    <field name="pop17" editable="1"/>
    <field name="pop18" editable="1"/>
    <field name="pop19" editable="1"/>
    <field name="popchng" editable="1"/>
    <field name="systm_nd_1" editable="1"/>
    <field name="systm_ndx_" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="Area"/>
    <field labelOnTop="0" name="GID_0"/>
    <field labelOnTop="0" name="GID_0_x"/>
    <field labelOnTop="0" name="GID_0_y"/>
    <field labelOnTop="0" name="GID_1"/>
    <field labelOnTop="0" name="NAME_0"/>
    <field labelOnTop="0" name="NAME_0_x"/>
    <field labelOnTop="0" name="NAME_0_y"/>
    <field labelOnTop="0" name="NAME_1"/>
    <field labelOnTop="0" name="NAME_1_x"/>
    <field labelOnTop="0" name="NAME_1_y"/>
    <field labelOnTop="0" name="VARNAME"/>
    <field labelOnTop="0" name="VARNAME_1"/>
    <field labelOnTop="0" name="VARNAME_1_"/>
    <field labelOnTop="0" name="VARNAME__1"/>
    <field labelOnTop="0" name="_ge_x"/>
    <field labelOnTop="0" name="_ge_y"/>
    <field labelOnTop="0" name="cats"/>
    <field labelOnTop="0" name="elctrpp"/>
    <field labelOnTop="0" name="eldff"/>
    <field labelOnTop="0" name="eldffpc"/>
    <field labelOnTop="0" name="eldiff"/>
    <field labelOnTop="0" name="elr14"/>
    <field labelOnTop="0" name="elr15"/>
    <field labelOnTop="0" name="elr16"/>
    <field labelOnTop="0" name="elr17"/>
    <field labelOnTop="0" name="elr18"/>
    <field labelOnTop="0" name="elr19"/>
    <field labelOnTop="0" name="elrat14"/>
    <field labelOnTop="0" name="elrat16"/>
    <field labelOnTop="0" name="elrat18"/>
    <field labelOnTop="0" name="ncc14"/>
    <field labelOnTop="0" name="ncc15"/>
    <field labelOnTop="0" name="ncc16"/>
    <field labelOnTop="0" name="ncc17"/>
    <field labelOnTop="0" name="ncc18"/>
    <field labelOnTop="0" name="ncc19"/>
    <field labelOnTop="0" name="pop14"/>
    <field labelOnTop="0" name="pop15"/>
    <field labelOnTop="0" name="pop16"/>
    <field labelOnTop="0" name="pop17"/>
    <field labelOnTop="0" name="pop18"/>
    <field labelOnTop="0" name="pop19"/>
    <field labelOnTop="0" name="popchng"/>
    <field labelOnTop="0" name="systm_nd_1"/>
    <field labelOnTop="0" name="systm_ndx_"/>
  </labelOnTop>
  <widgets/>
  <previewExpression>GID_1</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>2</layerGeometryType>
</qgis>
