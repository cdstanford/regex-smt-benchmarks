;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AA.d@\u00AA.\u00BA.\u00CA.Rz.u.aAz"
(define-fun Witness1 () String (seq.++ "\xaa" (seq.++ "." (seq.++ "d" (seq.++ "@" (seq.++ "\xaa" (seq.++ "." (seq.++ "\xba" (seq.++ "." (seq.++ "\xca" (seq.++ "." (seq.++ "R" (seq.++ "z" (seq.++ "." (seq.++ "u" (seq.++ "." (seq.++ "a" (seq.++ "A" (seq.++ "z" "")))))))))))))))))))
;witness2: "7.-.\u00C6@\u00B5-_.aZLs"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "\xc6" (seq.++ "@" (seq.++ "\xb5" (seq.++ "-" (seq.++ "_" (seq.++ "." (seq.++ "a" (seq.++ "Z" (seq.++ "L" (seq.++ "s" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." ".")))(re.++ ((_ re.loop 2 7) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
