;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9_.-]*@[a-z0-9-]+(.[a-z]{2,4})+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "@-ch\u00E4zvmc]hxa"
(define-fun Witness1 () String (seq.++ "@" (seq.++ "-" (seq.++ "c" (seq.++ "h" (seq.++ "\xe4" (seq.++ "z" (seq.++ "v" (seq.++ "m" (seq.++ "c" (seq.++ "]" (seq.++ "h" (seq.++ "x" (seq.++ "a" ""))))))))))))))
;witness2: "8x@7\u0095tc\u00C7wzva\u00F1uz"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "x" (seq.++ "@" (seq.++ "7" (seq.++ "\x95" (seq.++ "t" (seq.++ "c" (seq.++ "\xc7" (seq.++ "w" (seq.++ "z" (seq.++ "v" (seq.++ "a" (seq.++ "\xf1" (seq.++ "u" (seq.++ "z" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.+ (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) ((_ re.loop 2 4) (re.range "a" "z")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
