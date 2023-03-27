;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <h([1-6])>([^<]*)</h([1-6])>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<h6>\"</h3>"
(define-fun Witness1 () String (str.++ "<" (str.++ "h" (str.++ "6" (str.++ ">" (str.++ "\u{22}" (str.++ "<" (str.++ "/" (str.++ "h" (str.++ "3" (str.++ ">" "")))))))))))
;witness2: "N\u00D9<h5>l</h6>\u00FB"
(define-fun Witness2 () String (str.++ "N" (str.++ "\u{d9}" (str.++ "<" (str.++ "h" (str.++ "5" (str.++ ">" (str.++ "l" (str.++ "<" (str.++ "/" (str.++ "h" (str.++ "6" (str.++ ">" (str.++ "\u{fb}" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "h" "")))(re.++ (re.range "1" "6")(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.range "\u{00}" ";") (re.range "=" "\u{ff}")))(re.++ (str.to_re (str.++ "<" (str.++ "/" (str.++ "h" ""))))(re.++ (re.range "1" "6") (re.range ">" ">")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
