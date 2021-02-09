;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[http|ftp|wap|https]{3,5}:\//\www\.\w*\.[com|net]{2,3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "h|s://\u00EDww.\u00C249\u00B5z.||n"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "|" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xed" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "\xc2" (seq.++ "4" (seq.++ "9" (seq.++ "\xb5" (seq.++ "z" (seq.++ "." (seq.++ "|" (seq.++ "|" (seq.++ "n" ""))))))))))))))))))))
;witness2: "aaf://nww.\u00FE.oot"
(define-fun Witness2 () String (seq.++ "a" (seq.++ "a" (seq.++ "f" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "n" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "\xfe" (seq.++ "." (seq.++ "o" (seq.++ "o" (seq.++ "t" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 5) (re.union (re.range "a" "a")(re.union (re.range "f" "f")(re.union (re.range "h" "h")(re.union (re.range "p" "p")(re.union (re.range "s" "t")(re.union (re.range "w" "w") (re.range "|" "|"))))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "c" "c")(re.union (re.range "e" "e")(re.union (re.range "m" "o")(re.union (re.range "t" "t") (re.range "|" "|")))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
