;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z0-9_\-\.]+)(@[a-zA-Z0-9_\-\.]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-_-@T"
(define-fun Witness1 () String (str.++ "-" (str.++ "_" (str.++ "-" (str.++ "@" (str.++ "T" ""))))))
;witness2: "-@a\u0085\x11"
(define-fun Witness2 () String (str.++ "-" (str.++ "@" (str.++ "a" (str.++ "\u{85}" (str.++ "\u{11}" ""))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.++ (re.range "@" "@") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
