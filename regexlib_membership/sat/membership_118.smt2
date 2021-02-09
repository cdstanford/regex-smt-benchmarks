;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = https?://[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*/\S*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://b-94/\x5\u00ED-\u00BE\u0086"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "b" (seq.++ "-" (seq.++ "9" (seq.++ "4" (seq.++ "/" (seq.++ "\x05" (seq.++ "\xed" (seq.++ "-" (seq.++ "\xbe" (seq.++ "\x86" ""))))))))))))))))))
;witness2: "http://xw.8Ra9.y/\u00C5>\u00D0\u00D8\x11"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "x" (seq.++ "w" (seq.++ "." (seq.++ "8" (seq.++ "R" (seq.++ "a" (seq.++ "9" (seq.++ "." (seq.++ "y" (seq.++ "/" (seq.++ "\xc5" (seq.++ ">" (seq.++ "\xd0" (seq.++ "\xd8" (seq.++ "\x11" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.range "/" "/") (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
