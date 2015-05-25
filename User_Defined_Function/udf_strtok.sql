CREATE Function udf_strtok (
     @sStringToParse    Varchar(max)
    ,@sSeparator        char(1)
    ,@nStartPosition    int
)
Returns @tbResult Table (
     Token             Varchar(max)
    ,NextStartPosition int
)
AS
Begin

    Declare    
         @nNextPos          int
        ,@nLenStringToParse int
        ,@sToken            varchar(max) 

    Select @nLenStringToParse = Len(@sStringToParse)

    -- Special case: input string is null
    If @sStringToParse Is Null
    Begin
        Select
             @nNextPos  = Null
            ,@sToken    = Null
    End

    -- Special case: separador is null. Return full input string
    Else If @sSeparator Is Null
    Begin
        Select
             @nNextPos  = @nLenStringToParse + 1
            ,@sToken    = Substring(@sStringToParse, @nStartPosition, @nLenStringToParse)
    End

    -- Special case: input string is empty. 
    Else If @nLenStringToParse = 0
    Begin
        If @nStartPosition = 1
            Select
                 @nNextPos  = 2
                ,@sToken    = @sStringToParse
        Else
            Select
                 @nNextPos  = @nStartPosition + 1
                ,@sToken    = Null
    End

    -- Special case: input string ends with separator
    Else If @nStartPosition = @nLenStringToParse + 1
        And Substring(@sStringToParse, @nLenStringToParse, 1) = @sSeparator
    Begin
        Select
             @nNextPos  = @nStartPosition + 1
            ,@sToken    = ''
    End

    -- In any other case if we are at the end of the input string, return null signalling end...
    Else If @nStartPosition > @nLenStringToParse
    Begin
        Select
             @nStartPosition = Null
            ,@sToken         = Null
    End

    -- Normal cases...
    Else
    Begin
        Select @nNextPos = CharIndex(@sSeparator, @sStringToParse, @nStartPosition)

        If @nNextPos Is Null
        Begin
            Select
                 @sToken    = Null
                ,@nNextPos  = Null
        End

        -- Separator not found: return the full string
        Else If @nNextPos = 0
        Begin
            If @nStartPosition = 0
                Select @sToken = @sStringToParse
            Else
                Select @sToken = SUBSTRING( @sStringToParse, @nStartPosition, @nLenStringToParse )

            Select @nNextPos = @nLenStringToParse + 1
        End
        Else 
        Begin
            Select @sToken = SUBSTRING( @sStringToParse, @nStartPosition, @nNextPos - @nStartPosition )
            Select @nNextPos = @nNextPos + 1
        End
        
        Set @nStartPosition = @nNextPos
    End

    Insert Into @tbResult (NextStartPosition, Token) 
    Values (@nNextPos, @sToken)
    Return

End
