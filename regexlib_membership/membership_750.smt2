;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\?&](?<name>[^&=]+)=(?<value>[^&=]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "S?\u0084=L"
(define-fun Witness1 () String (str.++ "S" (str.++ "?" (str.++ "\u{84}" (str.++ "=" (str.++ "L" ""))))))
;witness2: "\x15(?f=\u00D3\u0080"
(define-fun Witness2 () String (str.++ "\u{15}" (str.++ "(" (str.++ "?" (str.++ "f" (str.++ "=" (str.++ "\u{d3}" (str.++ "\u{80}" ""))))))))

(assert (= regexA (re.++ (re.union (re.range "&" "&") (re.range "?" "?"))(re.++ (re.+ (re.union (re.range "\u{00}" "%")(re.union (re.range "'" "<") (re.range ">" "\u{ff}"))))(re.++ (re.range "=" "=") (re.+ (re.union (re.range "\u{00}" "%")(re.union (re.range "'" "<") (re.range ">" "\u{ff}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
