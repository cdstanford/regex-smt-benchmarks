;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]:|\\)\\)?(((\.)|(\.\.)|([^\\/:\*\?"\|<>\. ](([^\\/:\*\?"\|<>\. ])|([^\\/:\*\?"\|<>]*[^\\/:\*\?"\|<>\. ]))?))\\)*[^\\/:\*\?"\|<>\. ](([^\\/:\*\?"\|<>\. ])|([^\\/:\*\?"\|<>]*[^\\/:\*\?"\|<>\. ]))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "..\[\u00D2\\u00B6\u00CB=\u0088"
(define-fun Witness1 () String (seq.++ "." (seq.++ "." (seq.++ "\x5c" (seq.++ "[" (seq.++ "\xd2" (seq.++ "\x5c" (seq.++ "\xb6" (seq.++ "\xcb" (seq.++ "=" (seq.++ "\x88" "")))))))))))
;witness2: "+\x1B"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "\x1b" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.range "\x5c" "\x5c")) (re.range "\x5c" "\x5c")))(re.++ (re.* (re.++ (re.union (re.range "." ".")(re.union (str.to_re (seq.++ "." (seq.++ "." ""))) (re.++ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.opt (re.union (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))))))))) (re.range "\x5c" "\x5c")))(re.++ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))(re.++ (re.opt (re.union (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
