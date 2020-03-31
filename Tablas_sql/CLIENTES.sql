CREATE TABLE "VIC"."CLIENTES"
  (
    "ID"          NUMBER(*,0) NOT NULL ENABLE,
    "NOMBRE"      VARCHAR2(200 BYTE) NOT NULL ENABLE,
    "VENDEDOR_ID" NUMBER(*,0) NOT NULL ENABLE,
    "ALIAS"       VARCHAR2(13 BYTE),
    "TAGS"        VARCHAR2(400 BYTE),
    "COND_PAGO"   NUMBER,
    "STATUS"      NUMBER,
    "AJ_COMISION" NUMBER,
    "AJ_COTIZ"    NUMBER,
    "LOGO" BLOB,
    "MIMETYPE"           VARCHAR2(48 BYTE),
    "FILENAME"           VARCHAR2(400 BYTE),
    "LASTUPDATED"        DATE,
    "CREATED"            DATE NOT NULL ENABLE,
    "CREATED_BY"         VARCHAR2(200 BYTE) NOT NULL ENABLE,
    "UPDATED"            DATE,
    "UPDATED_BY"         VARCHAR2(200 BYTE),
    "CUENTA_REVISADA"    DATE,
    "CUENTA_REVISADA_BY" VARCHAR2(80 BYTE),
    "LISTA_PRECIO"       NUMBER DEFAULT 0 NOT NULL ENABLE,
    "OBS"                VARCHAR2(400 BYTE),
    "CLI_GRUPO_ID"       NUMBER,
    CONSTRAINT "CLIENTES_PK" PRIMARY KEY ("ID") USING INDEX
    (CREATE INDEX "VIC"."CLIENTES_I" ON "VIC"."CLIENTES"
      (
        "ID"
      )
      PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
      (
        INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
      )
      TABLESPACE "VICKY"
    ) ENABLE,
    CONSTRAINT "VENDEDOR_KF1" FOREIGN KEY ("VENDEDOR_ID") REFERENCES "VIC"."VENDEDORES" ("ID") ENABLE
  )
  SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
  )
  TABLESPACE "VICKY" LOB
  (
    "LOGO"
  )
  STORE AS BASICFILE "CLIENTES_LOGO"
  (
    TABLESPACE "VICKY_LOB" ENABLE STORAGE IN ROW CHUNK 8192 RETENTION CACHE READS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ) ;
CREATE OR REPLACE EDITIONABLE TRIGGER "VIC"."CLIENTES_TRG" BEFORE
  INSERT ON CLIENTES FOR EACH ROW BEGIN IF :NEW.ID IS NULL THEN
  SELECT MAX (ID) +1 INTO :NEW.ID FROM CLIENTES;
END IF;
:new.STATUS     := 1;
:new.created    := sysdate;
:new.created_by := NVL(v('APP_USER'),USER);
END;
/
ALTER TRIGGER "VIC"."CLIENTES_TRG" ENABLE;
CREATE OR REPLACE EDITIONABLE TRIGGER "VIC"."CLIENTES_TRG_UPDATE" BEFORE
  UPDATE OF nombre,
    vendedor_id,
    cond_pago,
    aj_cotiz,
    aj_comision ON CLIENTES FOR EACH ROW BEGIN :new.updated := sysdate;
  :new.updated_by                                           := NVL(v('APP_USER'),USER);
END;
/
ALTER TRIGGER "VIC"."CLIENTES_TRG_UPDATE" ENABLE;