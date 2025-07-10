;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0][x][0-9a-fA-F]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0xCc\u00D1x"
(define-fun Witness1 () String (str.++ "0" (str.++ "x" (str.++ "C" (str.++ "c" (str.++ "\u{d1}" (str.++ "x" "")))))))
;witness2: "\xC]\u009B\u00E6\x190x09cA"
(define-fun Witness2 () String (str.++ "\u{0c}" (str.++ "]" (str.++ "\u{9b}" (str.++ "\u{e6}" (str.++ "\u{19}" (str.++ "0" (str.++ "x" (str.++ "0" (str.++ "9" (str.++ "c" (str.++ "A" ""))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "0" (str.++ "x" ""))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
