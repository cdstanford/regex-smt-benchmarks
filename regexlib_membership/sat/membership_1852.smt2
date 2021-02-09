;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\w\-\.]+)@((\[([0-9]{1,3}\.){3}[0-9]{1,3}\])|(([\w\-]+\.)+)([a-zA-Z]{2,4}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DB\u00DD-.@[45.9.8.892]"
(define-fun Witness1 () String (seq.++ "\xdb" (seq.++ "\xdd" (seq.++ "-" (seq.++ "." (seq.++ "@" (seq.++ "[" (seq.++ "4" (seq.++ "5" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "]" ""))))))))))))))))))
;witness2: "\u00BA@\u00AA.Eu-7\u00F5\u00B5.DxwQ"
(define-fun Witness2 () String (seq.++ "\xba" (seq.++ "@" (seq.++ "\xaa" (seq.++ "." (seq.++ "E" (seq.++ "u" (seq.++ "-" (seq.++ "7" (seq.++ "\xf5" (seq.++ "\xb5" (seq.++ "." (seq.++ "D" (seq.++ "x" (seq.++ "w" (seq.++ "Q" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." ".")))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "]" "]")))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." "."))) ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
