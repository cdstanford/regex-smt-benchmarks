;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<a[^>]*(http://[^"]*)[^>]*>([ 0-9a-zA-Z]+)</a>$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<ahttp://\x1A\u00EFC\u00F1>  </a>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "a" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\x1a" (seq.++ "\xef" (seq.++ "C" (seq.++ "\xf1" (seq.++ ">" (seq.++ " " (seq.++ " " (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" "")))))))))))))))))))))
;witness2: "<a\'http://;\u00C4_H>x</a>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "a" (seq.++ "'" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ ";" (seq.++ "\xc4" (seq.++ "_" (seq.++ "H" (seq.++ ">" (seq.++ "x" (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "<" (seq.++ "a" "")))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))) (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.range ">" ">")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" ""))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
