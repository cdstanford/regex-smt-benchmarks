;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<a[^>]*(http://[^"]*)[^>]*>([ 0-9a-zA-Z]+)</a>$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<ahttp://\x1A\u00EFC\u00F1>  </a>"
(define-fun Witness1 () String (str.++ "<" (str.++ "a" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{1a}" (str.++ "\u{ef}" (str.++ "C" (str.++ "\u{f1}" (str.++ ">" (str.++ " " (str.++ " " (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" "")))))))))))))))))))))
;witness2: "<a\'http://;\u00C4_H>x</a>"
(define-fun Witness2 () String (str.++ "<" (str.++ "a" (str.++ "'" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ ";" (str.++ "\u{c4}" (str.++ "_" (str.++ "H" (str.++ ">" (str.++ "x" (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "<" (str.++ "a" "")))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))) (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.range ">" ">")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (str.to_re (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" ""))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
