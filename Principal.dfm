object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Inspector de archivos '#39'dump'#39' de MySQL'
  ClientHeight = 442
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    624
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object lblArchivo: TLabel
    Left = 8
    Top = 13
    Width = 40
    Height = 13
    Caption = 'Archivo:'
  end
  object edtArchivo: TEdit
    Left = 54
    Top = 10
    Width = 531
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
  end
  object btnArchivo: TButton
    Left = 591
    Top = 8
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    OnClick = btnArchivoClick
  end
  object trvContenido: TTreeView
    Left = 8
    Top = 39
    Width = 608
    Height = 395
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    TabOrder = 2
  end
end
