;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (<b>)([^<>]+)(</b>)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "H[\u00A1\u00AEt<b>X</b>\x1C^<"
(define-fun Witness1 () String (str.++ "H" (str.++ "[" (str.++ "\u{a1}" (str.++ "\u{ae}" (str.++ "t" (str.++ "<" (str.++ "b" (str.++ ">" (str.++ "X" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ ">" (str.++ "\u{1c}" (str.++ "^" (str.++ "<" "")))))))))))))))))
;witness2: "<b>\u0087\u00EA</b>\u00D3\u00BE8"
(define-fun Witness2 () String (str.++ "<" (str.++ "b" (str.++ ">" (str.++ "\u{87}" (str.++ "\u{ea}" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ ">" (str.++ "\u{d3}" (str.++ "\u{be}" (str.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "b" (str.++ ">" ""))))(re.++ (re.+ (re.union (re.range "\u{00}" ";")(re.union (re.range "=" "=") (re.range "?" "\u{ff}")))) (str.to_re (str.++ "<" (str.++ "/" (str.++ "b" (str.++ ">" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
