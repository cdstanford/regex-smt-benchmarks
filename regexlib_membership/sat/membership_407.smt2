;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9_.-]*@[a-z0-9-]+(.[a-z]{2,4})+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "@-ch\u00E4zvmc]hxa"
(define-fun Witness1 () String (str.++ "@" (str.++ "-" (str.++ "c" (str.++ "h" (str.++ "\u{e4}" (str.++ "z" (str.++ "v" (str.++ "m" (str.++ "c" (str.++ "]" (str.++ "h" (str.++ "x" (str.++ "a" ""))))))))))))))
;witness2: "8x@7\u0095tc\u00C7wzva\u00F1uz"
(define-fun Witness2 () String (str.++ "8" (str.++ "x" (str.++ "@" (str.++ "7" (str.++ "\u{95}" (str.++ "t" (str.++ "c" (str.++ "\u{c7}" (str.++ "w" (str.++ "z" (str.++ "v" (str.++ "a" (str.++ "\u{f1}" (str.++ "u" (str.++ "z" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.+ (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 2 4) (re.range "a" "z")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
