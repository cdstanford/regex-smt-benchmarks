;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (pwd|password)\s*=\s*(?<pwd>('(([^'])|(''))+'|[^';]+))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "pwd=\'I\u009A\'"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "w" (seq.++ "d" (seq.++ "=" (seq.++ "'" (seq.++ "I" (seq.++ "\x9a" (seq.++ "'" "")))))))))
;witness2: "\u00E6\x15\u00EEpassword=\x9B"
(define-fun Witness2 () String (seq.++ "\xe6" (seq.++ "\x15" (seq.++ "\xee" (seq.++ "p" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ "\x09" (seq.++ "B" "")))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "p" (seq.++ "w" (seq.++ "d" "")))) (str.to_re (seq.++ "p" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" ""))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.range "'" "'")(re.++ (re.+ (re.union (re.union (re.range "\x00" "&") (re.range "(" "\xff")) (str.to_re (seq.++ "'" (seq.++ "'" ""))))) (re.range "'" "'"))) (re.+ (re.union (re.range "\x00" "&")(re.union (re.range "(" ":") (re.range "<" "\xff")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
