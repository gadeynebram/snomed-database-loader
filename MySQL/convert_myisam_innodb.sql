use snomedct;

drop table associationrefset_f;
drop table attributevaluerefset_f;
drop table complexmaprefset_f;
drop table concept_f;
drop table description_f;
drop table extendedmaprefset_f;
drop table langrefset_f;
drop table relationship_f;
drop table simplemaprefset_f;
drop table simplerefset_f;
drop table stated_relationship_f;
drop table textdefinition_f;

ALTER TABLE associationrefset_s ENGINE=InnoDB;
ALTER TABLE attributevaluerefset_s ENGINE=InnoDB;
ALTER TABLE complexmaprefset_s ENGINE=InnoDB;
ALTER TABLE concept_s ENGINE=InnoDB;
ALTER TABLE description_s ENGINE=InnoDB;
ALTER TABLE extendedmaprefset_s ENGINE=InnoDB;
ALTER TABLE langrefset_s ENGINE=InnoDB;
ALTER TABLE relationship_s ENGINE=InnoDB;
ALTER TABLE simplemaprefset_s ENGINE=InnoDB;
ALTER TABLE simplerefset_s ENGINE=InnoDB;
ALTER TABLE stated_relationship_s ENGINE=InnoDB;
ALTER TABLE textdefinition_s ENGINE=InnoDB;

ALTER TABLE stated_transclos ENGINE=InnoDB;
ALTER TABLE transclos ENGINE=InnoDB;

ALTER TABLE concept_s ADD CONSTRAINT pk_concept_s PRIMARY KEY(id);
alter table concept_s add constraint fk_concept_s_moduleid foreign key (moduleid) references concept_s(id);
alter table concept_s add constraint fk_concept_s_definitionstatusid foreign key (definitionstatusid) references concept_s(id);
alter table concept_s modify active bit not null;
    
ALTER TABLE description_s ADD CONSTRAINT pk_description_s PRIMARY KEY(id);
ALTER TABLE description_s add constraint fk_description_s_moduleid foreign key (moduleid) references concept_s(id);
alter table description_s modify active bit not null;
ALTER TABLE description_s add constraint fk_description_s_conceptid foreign key (conceptid) references concept_s(id);
ALTER TABLE description_s add constraint fk_description_s_typeid foreign key (typeid) references concept_s(id);
ALTER TABLE description_s add constraint fk_description_s_casesignificanceid foreign key (casesignificanceid) references concept_s(id);

ALTER TABLE relationship_s ADD CONSTRAINT pk_relationship_s PRIMARY KEY(id);
ALTER TABLE relationship_s add constraint fk_relationship_s_moduleid foreign key (moduleid) references concept_s(id);
alter table relationship_s modify active bit not null;
ALTER TABLE relationship_s add constraint fk_relationship_s_sourceid foreign key (sourceid) references concept_s(id);
ALTER TABLE relationship_s add constraint fk_relationship_s_destinationid foreign key (destinationid) references concept_s(id);
ALTER TABLE relationship_s add constraint fk_relationship_s_typeid foreign key (typeid) references concept_s(id);
ALTER TABLE relationship_s add constraint fk_relationship_s_characteristictypeid foreign key (characteristictypeid) references concept_s(id);
ALTER TABLE relationship_s add constraint fk_relationship_s_modifierid foreign key (modifierid) references concept_s(id);

ALTER TABLE langrefset_s ADD CONSTRAINT pk_langrefset_s PRIMARY KEY(id);
ALTER TABLE langrefset_s add constraint fk_langrefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table langrefset_s modify active bit not null;
ALTER TABLE langrefset_s add constraint fk_langrefset_s_refsetid foreign key (refsetid) references concept_s(id);
ALTER TABLE langrefset_s add constraint fk_langrefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
ALTER TABLE langrefset_s add constraint fk_langrefset_s_acceptabilityid foreign key (acceptabilityid) references concept_s(id);

ALTER TABLE associationrefset_s ADD CONSTRAINT pk_associationrefset_s PRIMARY KEY(id);
ALTER TABLE associationrefset_s add constraint fk_associationrefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table associationrefset_s modify active bit not null;
ALTER TABLE associationrefset_s add constraint fk_associationrefset_s_refsetid foreign key (refsetid) references concept_s(id);
-- fails
-- ALTER TABLE associationrefset_s add constraint fk_associationrefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
ALTER TABLE associationrefset_s add constraint fk_associationrefset_s_targetcomponentid foreign key (targetcomponentid) references concept_s(id);

ALTER TABLE attributevaluerefset_s ADD CONSTRAINT pk_attributevaluerefset_s PRIMARY KEY(id);
ALTER TABLE attributevaluerefset_s add constraint fk_attributevaluerefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table attributevaluerefset_s modify active bit not null;
ALTER TABLE attributevaluerefset_s add constraint fk_attributevaluerefset_s_refsetid foreign key (refsetid) references concept_s(id);
-- fails
-- ALTER TABLE attributevaluerefset_s add constraint fk_attributevaluerefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
ALTER TABLE attributevaluerefset_s add constraint fk_attributevaluerefset_s_valueid foreign key (valueid) references concept_s(id);

ALTER TABLE complexmaprefset_s ADD CONSTRAINT pk_complexmaprefset_s PRIMARY KEY(id);
ALTER TABLE complexmaprefset_s add constraint fk_complexmaprefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table complexmaprefset_s modify active bit not null;
ALTER TABLE complexmaprefset_s add constraint fk_complexmaprefset_s_refsetid foreign key (refsetid) references concept_s(id);
ALTER TABLE complexmaprefset_s add constraint fk_complexmaprefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
ALTER TABLE complexmaprefset_s add constraint fk_complexmaprefset_s_mapTarget foreign key (mapTarget) references concept_s(id);
ALTER TABLE complexmaprefset_s add constraint fk_complexmaprefset_s_correlationId foreign key (correlationId) references concept_s(id);

ALTER TABLE extendedmaprefset_s ADD CONSTRAINT pk_extendedmaprefset_s PRIMARY KEY(id);
ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table extendedmaprefset_s modify active bit not null;
ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_refsetid foreign key (refsetid) references concept_s(id);
ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
-- fails
-- ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_mapTarget foreign key (mapTarget) references concept_s(id);
ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_correlationId foreign key (correlationId) references concept_s(id);
ALTER TABLE extendedmaprefset_s add constraint fk_extendedmaprefset_s_mapCategoryId foreign key (mapCategoryId) references concept_s(id);

ALTER TABLE simplemaprefset_s ADD CONSTRAINT pk_simplemaprefset_s PRIMARY KEY(id);
ALTER TABLE simplemaprefset_s add constraint fk_simplemaprefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table simplemaprefset_s modify active bit not null;
ALTER TABLE simplemaprefset_s add constraint fk_simplemaprefset_s_refsetid foreign key (refsetid) references concept_s(id);
ALTER TABLE simplemaprefset_s add constraint fk_simplemaprefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
ALTER TABLE simplemaprefset_s add constraint fk_simplemaprefset_s_mapTarget foreign key (mapTarget) references concept_s(id);

ALTER TABLE simplerefset_s ADD CONSTRAINT pk_simplerefset_s PRIMARY KEY(id);
ALTER TABLE simplerefset_s add constraint fk_simplerefset_s_moduleid foreign key (moduleid) references concept_s(id);
alter table simplerefset_s modify active bit not null;
ALTER TABLE simplerefset_s add constraint fk_simplerefset_s_refsetid foreign key (refsetid) references concept_s(id);
ALTER TABLE simplerefset_s add constraint fk_simplerefset_s_referencedcomponentid foreign key (referencedcomponentid) references concept_s(id);
-- 
ALTER TABLE stated_relationship_s ADD CONSTRAINT pk_stated_relationship_s PRIMARY KEY(id);
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_moduleid foreign key (moduleid) references concept_s(id);
alter table stated_relationship_s modify active bit not null;
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_sourceid foreign key (sourceid) references concept_s(id);
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_destinationid foreign key (destinationid) references concept_s(id);
-- fails
-- ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_relationshipgroup foreign key (relationshipgroup) references concept_s(id);
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_typeid foreign key (typeid) references concept_s(id);
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_characteristictypeid foreign key (characteristictypeid) references concept_s(id);
ALTER TABLE stated_relationship_s add constraint fk_stated_relationship_s_modifierid foreign key (modifierid) references concept_s(id);

ALTER TABLE textdefinition_s ADD CONSTRAINT pk_textdefinition_s PRIMARY KEY(id);
ALTER TABLE textdefinition_s add constraint fk_textdefinition_s_moduleid foreign key (moduleid) references concept_s(id);
alter table textdefinition_s modify active bit not null;
ALTER TABLE textdefinition_s add constraint fk_textdefinition_s_conceptid foreign key (conceptid) references concept_s(id);
ALTER TABLE textdefinition_s add constraint fk_textdefinition_s_typeid foreign key (typeid) references concept_s(id);
ALTER TABLE textdefinition_s add constraint fk_textdefinition_s_casesignificanceid foreign key (casesignificanceid) references concept_s(id);
