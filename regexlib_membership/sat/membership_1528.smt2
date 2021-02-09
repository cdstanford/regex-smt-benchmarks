;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8@ly.z4.Zt.mp"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "@" (seq.++ "l" (seq.++ "y" (seq.++ "." (seq.++ "z" (seq.++ "4" (seq.++ "." (seq.++ "Z" (seq.++ "t" (seq.++ "." (seq.++ "m" (seq.++ "p" ""))))))))))))))
;witness2: "9\u00AAzGK8@P\u00E68k.sosT"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "\xaa" (seq.++ "z" (seq.++ "G" (seq.++ "K" (seq.++ "8" (seq.++ "@" (seq.++ "P" (seq.++ "\xe6" (seq.++ "8" (seq.++ "k" (seq.++ "." (seq.++ "s" (seq.++ "o" (seq.++ "s" (seq.++ "T" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.range "." "."))))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
