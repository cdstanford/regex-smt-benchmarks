;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".@C\u00F2\u00EB9\u00C1\u00C1.\u00AA\u00DB\u00AA"
(define-fun Witness1 () String (seq.++ "." (seq.++ "@" (seq.++ "C" (seq.++ "\xf2" (seq.++ "\xeb" (seq.++ "9" (seq.++ "\xc1" (seq.++ "\xc1" (seq.++ "." (seq.++ "\xaa" (seq.++ "\xdb" (seq.++ "\xaa" "")))))))))))))
;witness2: "\u00CC\u00F6@\u00B5.e\u00C5"
(define-fun Witness2 () String (seq.++ "\xcc" (seq.++ "\xf6" (seq.++ "@" (seq.++ "\xb5" (seq.++ "." (seq.++ "e" (seq.++ "\xc5" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." ".")))(re.++ ((_ re.loop 2 4) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
