;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Q@\u00C2-\u00AA\u00FE.\u00F6x"
(define-fun Witness1 () String (seq.++ "Q" (seq.++ "@" (seq.++ "\xc2" (seq.++ "-" (seq.++ "\xaa" (seq.++ "\xfe" (seq.++ "." (seq.++ "\xf6" (seq.++ "x" ""))))))))))
;witness2: "\u00AA@-58.U4\u00B5-.aA0"
(define-fun Witness2 () String (seq.++ "\xaa" (seq.++ "@" (seq.++ "-" (seq.++ "5" (seq.++ "8" (seq.++ "." (seq.++ "U" (seq.++ "4" (seq.++ "\xb5" (seq.++ "-" (seq.++ "." (seq.++ "a" (seq.++ "A" (seq.++ "0" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." ".")))(re.++ ((_ re.loop 2 3) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
