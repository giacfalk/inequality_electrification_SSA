<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" simplifyDrawingHints="1" simplifyAlgorithm="0" minScale="1e+08" simplifyLocal="1" maxScale="0" version="3.4.14-Madeira" readOnly="0" labelsEnabled="0" simplifyMaxScale="1" simplifyDrawingTol="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 enableorderby="0" type="RuleRenderer" forceraster="0" symbollevels="0">
    <rules key="{7497590b-1712-4f33-a7f5-d42c79467ee3}">
      <rule symbol="0" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) &lt; 0.000000 AND (&quot;popchng&quot;&lt;0)" key="{380b82a5-c7dd-4314-97be-a3152c4febfc}" label="Declining population"/>
      <rule symbol="1" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) &lt; 0.000000 AND (&quot;elctrpp&quot;&lt;0)" key="{143644a0-b654-487e-a70c-0c357a5b6584}" label="Declining electrification"/>
      <rule symbol="2" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 0.250000" key="{e5ae452b-fe2b-40c9-8bb2-15f746380e7f}" label="Electr. up to 75% slower than pop. growth"/>
      <rule symbol="3" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.250000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 0.750000" key="{c7200df7-9fa4-411f-b209-2581af0b449c}" label="Electr. up to 50% slower than pop. growth"/>
      <rule symbol="4" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 0.750000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.000000" key="{c0039e61-0e60-4d0b-baf1-de309908e5b8}" label="Electr. up to 25% slower than pop. growth"/>
      <rule symbol="5" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.000000" key="{ff5179f5-5674-4cc6-9c29-1acf30006575}" label="Same pace"/>
      <rule symbol="6" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.000000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.250000" key="{e90c8d2a-eeb2-44db-b4db-cafa7fd26531}" label="Electr. up to 25% faster than pop. growth"/>
      <rule symbol="7" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.250000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 1.500000" key="{5c453161-ba76-4d9b-a6ed-40013e8adf27}" label="Electr. up to 50% faster than pop. growth"/>
      <rule symbol="8" filter="(&quot;elctrpp&quot; / &quot;popchng&quot;) > 1.500000 AND (&quot;elctrpp&quot; / &quot;popchng&quot;) &lt;= 185.138858" key="{0d419c15-1fd7-49ca-909f-70a100b3062d}" label="Electr. up to 75% faster than pop. growth"/>
    </rules>
    <symbols>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="0">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="15,74,9,255"/>
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="1">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="141,90,153,255"/>
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="2">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="3">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="4">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="5">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="6">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="7">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="1" force_rhr="0" type="fill" clip_to_extent="1" name="8">
        <layer locked="0" class="SimpleFill" enabled="1" pass="0">
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
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <customproperties>
    <property key="dualview/previewExpressions">
      <value>GID_1</value>
    </property>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory penAlpha="255" penColor="#000000" penWidth="0" height="15" backgroundAlpha="255" enabled="0" sizeType="MM" scaleDependency="Area" barWidth="5" lineSizeScale="3x:0,0,0,0,0,0" scaleBasedVisibility="0" lineSizeType="MM" minimumSize="0" minScaleDenominator="0" sizeScale="3x:0,0,0,0,0,0" opacity="1" labelPlacementMethod="XHeight" backgroundColor="#ffffff" maxScaleDenominator="1e+08" width="15" diagramOrientation="Up" rotationOffset="270">
      <fontProperties description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      <attribute color="#000000" field="" label=""/>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings dist="0" priority="0" zIndex="0" showAll="1" placement="1" linePlacementFlags="18" obstacle="0">
    <properties>
      <Option type="Map">
        <Option type="QString" value="" name="name"/>
        <Option name="properties"/>
        <Option type="QString" value="collection" name="type"/>
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
    <field name="GID_0_x">
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
    <field name="VARNAME">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elrat18">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elrat16">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="elrat14">
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
    <field name="pop18">
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
    <field name="eldiff">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="eldffpc">
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
    <field name="cats">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="Area">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="GID_1" name=""/>
    <alias index="1" field="GID_0_x" name=""/>
    <alias index="2" field="NAME_0" name=""/>
    <alias index="3" field="NAME_1" name=""/>
    <alias index="4" field="VARNAME" name=""/>
    <alias index="5" field="elrat18" name=""/>
    <alias index="6" field="elrat16" name=""/>
    <alias index="7" field="elrat14" name=""/>
    <alias index="8" field="GID_0_y" name=""/>
    <alias index="9" field="pop18" name=""/>
    <alias index="10" field="pop14" name=""/>
    <alias index="11" field="eldiff" name=""/>
    <alias index="12" field="eldffpc" name=""/>
    <alias index="13" field="elctrpp" name=""/>
    <alias index="14" field="popchng" name=""/>
    <alias index="15" field="cats" name=""/>
    <alias index="16" field="Area" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default applyOnUpdate="0" expression="" field="GID_1"/>
    <default applyOnUpdate="0" expression="" field="GID_0_x"/>
    <default applyOnUpdate="0" expression="" field="NAME_0"/>
    <default applyOnUpdate="0" expression="" field="NAME_1"/>
    <default applyOnUpdate="0" expression="" field="VARNAME"/>
    <default applyOnUpdate="0" expression="" field="elrat18"/>
    <default applyOnUpdate="0" expression="" field="elrat16"/>
    <default applyOnUpdate="0" expression="" field="elrat14"/>
    <default applyOnUpdate="0" expression="" field="GID_0_y"/>
    <default applyOnUpdate="0" expression="" field="pop18"/>
    <default applyOnUpdate="0" expression="" field="pop14"/>
    <default applyOnUpdate="0" expression="" field="eldiff"/>
    <default applyOnUpdate="0" expression="" field="eldffpc"/>
    <default applyOnUpdate="0" expression="" field="elctrpp"/>
    <default applyOnUpdate="0" expression="" field="popchng"/>
    <default applyOnUpdate="0" expression="" field="cats"/>
    <default applyOnUpdate="0" expression="" field="Area"/>
  </defaults>
  <constraints>
    <constraint field="GID_1" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="GID_0_x" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="NAME_0" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="NAME_1" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="VARNAME" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="elrat18" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="elrat16" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="elrat14" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="GID_0_y" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="pop18" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="pop14" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="eldiff" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="eldffpc" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="elctrpp" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="popchng" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="cats" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
    <constraint field="Area" unique_strength="0" exp_strength="0" notnull_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="GID_1" exp=""/>
    <constraint desc="" field="GID_0_x" exp=""/>
    <constraint desc="" field="NAME_0" exp=""/>
    <constraint desc="" field="NAME_1" exp=""/>
    <constraint desc="" field="VARNAME" exp=""/>
    <constraint desc="" field="elrat18" exp=""/>
    <constraint desc="" field="elrat16" exp=""/>
    <constraint desc="" field="elrat14" exp=""/>
    <constraint desc="" field="GID_0_y" exp=""/>
    <constraint desc="" field="pop18" exp=""/>
    <constraint desc="" field="pop14" exp=""/>
    <constraint desc="" field="eldiff" exp=""/>
    <constraint desc="" field="eldffpc" exp=""/>
    <constraint desc="" field="elctrpp" exp=""/>
    <constraint desc="" field="popchng" exp=""/>
    <constraint desc="" field="cats" exp=""/>
    <constraint desc="" field="Area" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig sortExpression="" sortOrder="0" actionWidgetStyle="dropDown">
    <columns>
      <column width="-1" hidden="0" type="field" name="GID_1"/>
      <column width="-1" hidden="0" type="field" name="GID_0_x"/>
      <column width="-1" hidden="0" type="field" name="NAME_0"/>
      <column width="-1" hidden="0" type="field" name="NAME_1"/>
      <column width="-1" hidden="0" type="field" name="VARNAME"/>
      <column width="-1" hidden="0" type="field" name="elrat18"/>
      <column width="-1" hidden="0" type="field" name="elrat16"/>
      <column width="-1" hidden="0" type="field" name="elrat14"/>
      <column width="-1" hidden="0" type="field" name="GID_0_y"/>
      <column width="-1" hidden="0" type="field" name="pop18"/>
      <column width="-1" hidden="0" type="field" name="pop14"/>
      <column width="-1" hidden="0" type="field" name="eldiff"/>
      <column width="-1" hidden="0" type="field" name="eldffpc"/>
      <column width="-1" hidden="0" type="field" name="elctrpp"/>
      <column width="-1" hidden="0" type="field" name="popchng"/>
      <column width="-1" hidden="0" type="field" name="cats"/>
      <column width="-1" hidden="1" type="actions"/>
      <column width="-1" hidden="0" type="field" name="Area"/>
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
    <field editable="1" name="Area"/>
    <field editable="1" name="GID_0_x"/>
    <field editable="1" name="GID_0_y"/>
    <field editable="1" name="GID_1"/>
    <field editable="1" name="NAME_0"/>
    <field editable="1" name="NAME_1"/>
    <field editable="1" name="VARNAME"/>
    <field editable="1" name="cats"/>
    <field editable="1" name="elctrpp"/>
    <field editable="1" name="eldffpc"/>
    <field editable="1" name="eldiff"/>
    <field editable="1" name="elrat14"/>
    <field editable="1" name="elrat16"/>
    <field editable="1" name="elrat18"/>
    <field editable="1" name="pop14"/>
    <field editable="1" name="pop18"/>
    <field editable="1" name="popchng"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="Area"/>
    <field labelOnTop="0" name="GID_0_x"/>
    <field labelOnTop="0" name="GID_0_y"/>
    <field labelOnTop="0" name="GID_1"/>
    <field labelOnTop="0" name="NAME_0"/>
    <field labelOnTop="0" name="NAME_1"/>
    <field labelOnTop="0" name="VARNAME"/>
    <field labelOnTop="0" name="cats"/>
    <field labelOnTop="0" name="elctrpp"/>
    <field labelOnTop="0" name="eldffpc"/>
    <field labelOnTop="0" name="eldiff"/>
    <field labelOnTop="0" name="elrat14"/>
    <field labelOnTop="0" name="elrat16"/>
    <field labelOnTop="0" name="elrat18"/>
    <field labelOnTop="0" name="pop14"/>
    <field labelOnTop="0" name="pop18"/>
    <field labelOnTop="0" name="popchng"/>
  </labelOnTop>
  <widgets/>
  <previewExpression>GID_1</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>2</layerGeometryType>
</qgis>
