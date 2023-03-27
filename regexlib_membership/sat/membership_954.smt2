;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = src=(?:\"|\')?(?<imgSrc>[^>]*[^/].(?:jpg|bmp|gif|png))(?:\"|\')?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B9\u008Esrc=-\u00A2png\'0\u00F3"
(define-fun Witness1 () String (str.++ "\u{b9}" (str.++ "\u{8e}" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "-" (str.++ "\u{a2}" (str.++ "p" (str.++ "n" (str.++ "g" (str.++ "'" (str.++ "0" (str.++ "\u{f3}" "")))))))))))))))
;witness2: "osrc=\'\u0091\u00AB\u00F1jpg"
(define-fun Witness2 () String (str.++ "o" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "'" (str.++ "\u{91}" (str.++ "\u{ab}" (str.++ "\u{f1}" (str.++ "j" (str.++ "p" (str.++ "g" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" "")))))(re.++ (re.opt (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'")))(re.++ (re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (str.to_re (str.++ "j" (str.++ "p" (str.++ "g" ""))))(re.union (str.to_re (str.++ "b" (str.++ "m" (str.++ "p" ""))))(re.union (str.to_re (str.++ "g" (str.++ "i" (str.++ "f" "")))) (str.to_re (str.++ "p" (str.++ "n" (str.++ "g" "")))))))))) (re.opt (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
