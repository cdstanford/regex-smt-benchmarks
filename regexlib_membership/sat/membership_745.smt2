;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[/]*([^/\\ \:\*\?"\<\>\|\.][^/\\\:\*\?\"\<\>\|]{0,63}/)*[^/\\ \:\*\?"\<\>\|\.][^/\\\:\*\?\"\<\>\|]{0,63}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0088\u00FE/\u00DD\x10\u00DE/-"
(define-fun Witness1 () String (seq.++ "\x88" (seq.++ "\xfe" (seq.++ "/" (seq.++ "\xdd" (seq.++ "\x10" (seq.++ "\xde" (seq.++ "/" (seq.++ "-" "")))))))))
;witness2: "l"
(define-fun Witness2 () String (seq.++ "l" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range "/" "/"))(re.++ (re.* (re.++ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))(re.++ ((_ re.loop 0 63) (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.range "/" "/"))))(re.++ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))(re.++ ((_ re.loop 0 63) (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
