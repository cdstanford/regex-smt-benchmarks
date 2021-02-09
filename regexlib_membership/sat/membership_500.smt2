;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BA.--.\u00AA.T.pj"
(define-fun Witness1 () String (seq.++ "\xba" (seq.++ "." (seq.++ "-" (seq.++ "-" (seq.++ "." (seq.++ "\xaa" (seq.++ "." (seq.++ "T" (seq.++ "." (seq.++ "p" (seq.++ "j" ""))))))))))))
;witness2: "V-\u00AA.\u00B5q"
(define-fun Witness2 () String (seq.++ "V" (seq.++ "-" (seq.++ "\xaa" (seq.++ "." (seq.++ "\xb5" (seq.++ "q" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "&")(re.union (re.range "-" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
